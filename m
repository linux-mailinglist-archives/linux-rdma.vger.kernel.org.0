Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9105927092D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRXb4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:31:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19288 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRXb4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 19:31:56 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f65433f0000>; Fri, 18 Sep 2020 16:31:11 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:31:55 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvCZ2ywcnOPpldCfAsENsGHvVnyl6EFRBoICjXT94VVQTk6iPfGCmNTD3UWF4h5HTiV40I+qBpAMV5FdIp3EnVCdJjagFnBsqDq0Y1Wc8V5YpOf78qA+6i6Q53jlok2rQU1bnQQ1KXe3UqMwzPT7FRsZ6ZCEBTsK7m1iqFDwJ98ddDNCqdlrHcLaJC7GuPb7u1B1Nv+ez4GcAbZJ2EApGdZ/4oQ8HJXsrUk7yFVDrl96yG6JDnabm6jjYYfp5zCvYVtNWdQlAT2RoY9YhuZkBCguZg+hc9Vegk/KvqNIWPY5c+Fp9PqhVoCJD0eirHwiXxf8e19qFJGZbktjs6s+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I4RV6D8hbwuTTbsoCo8RrmUvUELDJMtS+e13z18/B4=;
 b=iEaKjEscawHH7HwtfEfM+Gx2QIe0ndxNhrTNVgi4tyC1CJ3AMm/dH6ThOnzdX+c2dEogIVEJtTTomNfH6SMCu2ht7BgS8JCWGDlAplP3BCcj+EFzq+rLA+qYtfLqXGMT4s+LJd+MTXtOqXYgDgYFG4A+0Y5XqvW0HbN3dHU6E055no0jMSKc3vlVSIBcnXB05zOogr3WARamctGGelb1u7PgUbESr0X2vw03WGVqsHH/ZYjX+z0VG+A9/b4+EeDRfF/HiJ/6z/PxnoVx2SkmxNI6ux7pWsWwKI7xdvF2SsRLTmursygogxF2+KTSVYz9K/WkdBeNtDpbAkgluyP/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 23:31:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:31:54 +0000
Date:   Fri, 18 Sep 2020 20:31:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v2 11/14] RDMA/restrack: Make restrack DB
 mandatory for IB objects
Message-ID: <20200918233152.GF3699@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-12-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-12-leon@kernel.org>
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0005.namprd22.prod.outlook.com (2603:10b6:208:238::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 23:31:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJPr6-001tTM-Gj; Fri, 18 Sep 2020 20:31:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ecd88cb-39f4-4bdf-631d-08d85c2b0684
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203892D5FA493EEF7C5F48FC23F0@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lnfWvTAdXXYrkEc8ZCAOMGM6+o1R2AhUcfOryAayra4F1KEdjYpFzGE5AFwtRU5RF/y84EIkMH/b9HtKMIvpF5XqRvug1uzNch8NNkEg6VUMYziRzO5/a2l4ltZk6OImqdCkrIkS08PZW0gSZy9Y5MAansQIr20Iv0GIXoy/S5DI6JO73Wn41dI2n6ibbVSoC9RTlqSHiWw6/hGyHsKVWxyNJjN8bJcy3ffC51fTSmjjqD3WEbxmSGH0BmN6xEBMkXbIXJwXFAYieIeBRXwNcUGFmNNLZ7gESHfmyX4XSTrUB/4TP4CyeXAxjk7swjdXFi3FX9Xy6uwDxhlRvMSxEVckF54uzVZpF+2Qf3SChS1Q26lCuFDNCHcjLTXSNJE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66556008)(36756003)(6916009)(86362001)(478600001)(316002)(9786002)(8936002)(9746002)(8676002)(2616005)(2906002)(107886003)(4326008)(66476007)(66946007)(1076003)(83380400001)(33656002)(54906003)(5660300002)(4744005)(426003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /GPf4ufY87mvk/+p1LKqAocTtM/A7lTuZxrpcCeQkJN3wzQlPPVYukealg5M6PT1nvoQr0xVgO32RHP6Y4qosSLKpDAp1AfbaSHzwt+BJ130KZWrXt/BNeaAeloPANzD/71NTt/SO5Jq7b+vk+pXfYgwQ2YoIQIG+TnUg4YBxe1Swzsdq3e3HB6Wm+Hr3de9uS+7eZWeQROQFaFDwQUe94uNMOSbsPYdim8+dw926/+bc1VlfnjECtSaKK/daKIKAMzs8Y+sR1rtj10l9BC6DBGQh7UaOalDTP7EtcynSLXpJ10ePV7o6VT5ZI4/D7rtdHK8wrn76gCXuvCYySMF2cnWlDFs1TQ0jP9mrXXNI040mE5+LxZCIMqKKXh5uwvAzSWzfQ7RIIJ8HPxTtsrzO2fO5CSVZBMrQYGDWi69IdONGJCLtvhPCbPMiR+F6DavKXPfOzDdSJNYkqwcR6Ii2G+p0aYinqoZgbL/igqxf0HHrHq7+HvR+6FQLPHR7pir7gsWpnOH0v73XSi5vhzwZ0mURmIlyymnuwAzAYUdYa1qZbndlGasXgvym764URXFDJiGrT2/7UdBeIlPlHMRFz0e8WN28MWsM8lsiwBPCfmbLJPnjOmdwAWokjRa5bpYbCxsN8c20l6ebZI01GkZsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecd88cb-39f4-4bdf-631d-08d85c2b0684
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:31:53.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc9SqZUt+mSWy/s8wem6PXuBtWrgp0OoNEp3LU44Wvdlmm+S86bBVkRZ6ZVPrvOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600471871; bh=+I4RV6D8hbwuTTbsoCo8RrmUvUELDJMtS+e13z18/B4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=PqvaH8/LG7YcIniF0KbP4VxiXTnYQTZ8y76d6MJtcOmBk2QRek0AQlsScxrZuFjdq
         wneOJB3xuRYt+XY24F5zbGXz9FVYaCSWBNtMErYpI5G0lWe317m7LErvFlL65Ql+6Z
         nxFLMslJMe9LDzb9P83VQN0tmUlck7OZwmffMskVZ45NXkkf7YAdqGEzk1rVswN/MZ
         YBeU3P073jZb+x40wTYnitEwVqVTJzxnI0fNq0g0BnQzXxcjidcy41xRKUXEGujNIF
         O8uYsWiFS5ZSRzc8Q/UkIiUgxSiQcXc8I1H6bZeNpjtH6ly9VC796Wg/4puJ5KBgTb
         g51BIFlZXR7lQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:53PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Restrack stores the IB objects in the internal xarray and insertion
> where can fail. As long as restrack was helper tool for the
> debuggability, such failure were ignored.
> 
> In the following patches, the ib_core will be changed to manage allocated
> IB objects in restrack DB for the proper memory lifetime. It requires to
> ensure that insertion errors are not ignored.

Why? This looks like it is all about removing valid, not sure what the
kref has to do with it..

Jason
