Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0534A7FA
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZNUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 09:20:09 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:49139
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229779AbhCZNUD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 09:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIdFGyhStTaUCFqxUCBTLBsqZAiReCd6IQyBlWPptW4nRuJfl+fhdK7uTtsqBe6OryYVEXf8qn2vTd4uFg/WitfefEx7CAw/EJnJrvxdkFybsyRXcLY3DIjCKNHpYLSrU/yjiFAP0dL6GCitiP8BYF3ycfmPrfodyI/xoIFTZ9p/uBEhua4Cgb02vJXcuQ1PPZp8CLHPFPKOnJzMZUvYORACZHCjzaPn0ZhqSxFOgXwEfhkD/dZuwLyISz8KCry3fREAPFdulniih9E2ScR8U82UAWeKlzbhMWto4rkg4ac1OFXPCjx14SpwP87NS8TShHX8qyfkLVxkssoIsi/3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRcUg0vU9INvf40Ezoe0qAtl3U3iWdvbx3+IuboIIZQ=;
 b=LCo8bPGpDP7STVnDIdJnE+ozY6wl/OB9VE3Cj+uxl+P/nEXyP/rLqp2RZEGFYthROwisrnElLTgkMVkQ6mMzHzjLeYOcRBcroXXgk8i6X0Er7H47ucTV9r5+CoHTb/uJkUW4ALiqkUexXLQoImz5S+Gs9LDxVUeH4aAhk4ZAIi/RgpDqU5wGA1nVqogpz7XAizv1wcW+Jz7LAx0i3s1D1t6ner3tM+nILx3c3ODme17BfBDVF63KsoOL7vs2XjtvcR1/h7Wu8EJO7f5A+V3caG9AZDAMHRLrpcNbeYnBR1JeWgvzYyNhs8c9Km7zxrvPiP5wLxow4kc8/dbjXY59Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRcUg0vU9INvf40Ezoe0qAtl3U3iWdvbx3+IuboIIZQ=;
 b=tdMn6whfbahmga2/aPZSKfxVD0DVNj7+R/OYWrSFfBcJwMlf1FXnzksESug6MKVIa9on4BGxMbwhGmObeSMxKUgjZQbkmYpmMe0JRDcG8u0aA8kqHK5LA3NqaJMBJAvixF8bnsSici9GdKFOiOVpuolI9sJvpr7HgZ/ed39DKhr5X2+P+wuMa+lWMHGiXhxZ4jM14KoZLtNV5BG2lL7PVVgBYj786loEsLaPOTeUlCXZm6SZBggrFTd8P9Qv588FWLl8Xc7nyqg1GnHaBIHZCUE8maro9HnwxZIgrkpZ4nmsL0G4VPWU838iHMTCigScmpdkCsUzFFY2buhsewdikw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 13:19:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 13:19:59 +0000
Date:   Fri, 26 Mar 2021 10:19:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Create ODP EQ only when ODP MR
 is created
Message-ID: <20210326131956.GB832996@nvidia.com>
References: <20210314125418.179716-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314125418.179716-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:257::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:257::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15 via Frontend Transport; Fri, 26 Mar 2021 13:19:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPmNY-003Uou-VC; Fri, 26 Mar 2021 10:19:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cece831-48ef-463c-66f6-08d8f059dac9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514DAE512E74D7B9FAA7AA9C2619@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7771M1JFhPaEud3ua2kvqbXrxMTlcbck1rtAoJV1oRrArVpBETBlojtPUde93kCdze9kuU6G+wEauikRyxuihn2AMgm54PwX5b7IAdFIGNFJ0glSR3/5zM960G/+UqKZmsl325MLozMVceG4sq7vAkBXafIpNJ4tWhCm2wZgnDtuARrOGVqsa4iiZJBb6lg3lQKgvCRUjEMcoa1qi0PTHLffrkKXdrdR7/5Ys3GbF1K97Y6dQlmvPEK+mb+oIH7kyE2b5FwvCUHOoOs+BMRZDJs9798JK0ksX52e9D95M9JIL5A6GOKfsM6mJyexjlToodhVT/MbrG5eZ8P+fseVy+sVWe7G2DjGNZIs+rTMwD+hYuRAuPzWteg6Aoe3CWfovjncUwPaUyyC19PGNAmFzgho8fcmMVB7GIm966w4N7r0qXE+vysGPe52RXKvwznYmrYiQZ3O66ho2R0LSKZ6BsVJPPXz563qHEC1Q2EAyBwH9SimyLgy5AnYk8m3UIDH8I+SRirfqts/qybBs5WbcbYJwxt9+hJFH5XZHJv9u/wP4XTo+Aa2A7RjuNSd7LnYCkDfx71yWN55fW/PrzDot5bOaKF5MJ7CMQp+ngJOpO9OvOy66YBsLvqo/jplhAGjWXhOQZxWfHuRc7EnwJz9r8nwdooJqGJjazK32aFiDb3BfUR8ZtRxdIjYqfArztSq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(86362001)(6916009)(316002)(5660300002)(1076003)(83380400001)(4744005)(33656002)(4326008)(66476007)(2906002)(36756003)(2616005)(66556008)(8936002)(426003)(107886003)(478600001)(26005)(186003)(9786002)(9746002)(38100700001)(8676002)(54906003)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MrpY8Yeypz9rcmqDT8J0gENP1WXwTZ03qgRTPi25Dy/yYyGylRYC7DzLhg+U?=
 =?us-ascii?Q?ti23vvipE9sNn9MP3JRUhZBB2p2m2CoBr2MqKEqO+WsqkTIkyiGficsQFCPo?=
 =?us-ascii?Q?BGWK4lZTe0MKhEpM30UZO8LHhg4Dntg+FVRcNT/OJUnMyOjPMMEgIU/uq8z0?=
 =?us-ascii?Q?QaZbSB0yqG0V+Bxov7V+XVW/6EGgCtdlDbu4gNYuPQ08GLMhd75tZVJ0xw+2?=
 =?us-ascii?Q?uJf0TPiVaWAXmaQCKSJCV9zkcv9I17+Q3FcFO7jU+Y8SC7KUEUGAH2H0S8NB?=
 =?us-ascii?Q?TMLL06iM9TaWx67ysPcPTmjCTv4Z1BE4xTrvy9NXzlzdezq7XmQLlX/7WWoq?=
 =?us-ascii?Q?juWL+X7HUAToALoO4U3s2bJdGV431PYjJgeMzRpT3Wm8qJzVvTrf0Zjapy2k?=
 =?us-ascii?Q?wV5xvZKOO+2BGSb/MkxUhzJnDkYKKRZfpuB4xZ8Rv/42f4YFH/3FZhIP4jeB?=
 =?us-ascii?Q?aWDk2Xbd7glPKhlpPeaRe+8WH6Jz1J6mgFhrjuWPTuvGEo+ZaUh3ORsz4j4B?=
 =?us-ascii?Q?QWSl0L8wvO387kAlIdDCRxXzvOlt7VhOmwxtVdEJ5l9b5eNSFxjGv7bomSa1?=
 =?us-ascii?Q?k2Furopeb9PC/AxtraCWV8NDQZO5j9Wl14DtX1LSMyYz7fRKQMmSYadq9TlN?=
 =?us-ascii?Q?pPiiDxTapq0v5NBJ+XXDY+6q93g+aI2/DttIGSMTEdWIUb0fKWShAKu4VclJ?=
 =?us-ascii?Q?uMte75512lH4LRBkIi42SbJzHzljTVPVdPODdC03ICOOvM4Db6797P+QDdNE?=
 =?us-ascii?Q?9WLAR41M7ZYgrlbdKjFSArprNtPquC9TcG5bQcip4ircZf60BLPIq97hr2c1?=
 =?us-ascii?Q?MohW+O+l0Th2UX5IMEaHJ2cf8gsTgV96abtLBdJ/cKIszu3KI0vyzUC7PuCw?=
 =?us-ascii?Q?XTu8iXIl/5bX5DFYC2Jp7JgGCXSZlEYowfLbzDEXNvn3aetkYux4haCmUiRe?=
 =?us-ascii?Q?X7gYzH9RuchlXZKi7xUetOiAI5kKdhcHJOLIT7sTrUFuvVaywOozIYkI1Q8Z?=
 =?us-ascii?Q?Lx/yGSxY0HSXAIJjLAcOAl+RU6WCULar+0r1q4jaRwfkMQMGL6SzOOq8xnfN?=
 =?us-ascii?Q?jaV9n+iRYcb8q4WnY+ypa1jiCp6xSWJJmhAr3JKUDFcz5EFDbEN1alkvZvfC?=
 =?us-ascii?Q?jZf5SwMagreubBP1vE5zpPvvTznNmJIDduc0Pa/p0cNvb/PqBM5QSshJH10l?=
 =?us-ascii?Q?Dg9riiy8gpdXsnhtDILoRNInoFV1KZBB2YWC/rJc03qyr+NnueXYUw7GF38g?=
 =?us-ascii?Q?BPGxYnZWvrjdeyKhPyFOf8zfThnojAMX4Yfv8zZZ4R0fGpsrkJ4mGk800u9S?=
 =?us-ascii?Q?hAIDiHsaP7m439Y4O/ChNVm/5X44Gv24jzWktcKTqPneNQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cece831-48ef-463c-66f6-08d8f059dac9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 13:19:59.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2pW/GeJ3/bO400tC5uQrClFlFoW3NC1bjLphMRlBOmCH5Hfger0cL12mWxdtCs2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 14, 2021 at 02:54:18PM +0200, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> There is no need to create the ODP EQ if the user doesn't use ODP MRs.
> Hence, create it only when the first ODP MR is created. This EQ will be
> destroyed only when the device is unloaded.
> This will decrease the number of EQs created per device. for example: If
> we creates 1K devices (SF/VF/etc'), than we will decrease the num of EQs
> by 1K.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Changelog:
>  v1:
>  * Delete optimization
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  7 +++++++
>  drivers/infiniband/hw/mlx5/mr.c      |  3 +++
>  drivers/infiniband/hw/mlx5/odp.c     | 29 ++++++++++++++++++----------
>  3 files changed, 29 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason
