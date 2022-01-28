Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD149FE91
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbiA1RAi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 12:00:38 -0500
Received: from mail-sn1anam02on2070.outbound.protection.outlook.com ([40.107.96.70]:65155
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239133AbiA1RAh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 12:00:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzqcxxfDOxXmc3kGL66wKaUajizulK44dfKStcuN18BsGEINIe/+7VTNg0yc3PcFIPLFHCyYrMRfwdypZoewwPWNrHYR8xIpvPbFDZICp9pFt0jCQoQ/HcAlawKO8G+4220zlUpqtbQoiuSzajb3DGXlia7vDXY6lJb5YSaWucL2bvQNl9NoTTBN3waAjntZE+C1P1m9HUZZvHO3d0NMVJ3yR4vkwPfLre4NI7dS+Yj6BYymcMcmeGR2uE8cknp5GOCNYuImx9Q6Df2MODcIrCtFtly4IQgaLtwzSB0gWuOqTXd0nhn1VTR1warvVQ+67nq2NyUArF3CauTDeUQREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cMw5Ir/ZystnzTLIcqQX3yOvucrh/rmV2beXXowESs=;
 b=h3vM72sSY8WGHzmDTsIMiam4abOoXYv+btspnfEzIU7RTrbxaqkaUtAnMvPWrDsa/JtBhZVFzSGoi5/BP0NktjGwr08g2RTeOJIHY1DWjfHdCb5X3IOvy5xv/FRAS+TsoPysfmZEtom5iEf6aRll5/ysIohOJDZOCUdItXQ/tbTXwo8cGP5ieoLvhmwwIXvNBsuWbZ1qIks1+wJ3aSV0IM0MgdyoK6OEXe4gNvD+GrVoJld6fCXSYpAw/AVPGup2W2azQhzAU1+KUsGHMIZaSIRvtCeYlYynnEwH72Shmx7UlADFB7EIm5LbOLsbbcs8p9ZRDKr/2jvHCbsvPfPdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cMw5Ir/ZystnzTLIcqQX3yOvucrh/rmV2beXXowESs=;
 b=KexZUWRH1ioaqlCgzsTpgpRyyFCWT89n2DYkR3MEuEblp4E2m8VxzzzUPmhId+2ddzpHwnexfuIw3H8hZoaTZs0DYMSfmnF3WBIbMjtcuIfuWkf6NcM5Vl2aUdKPtXJqwiaBUU3Ygv2z1JdoeT7Z12lMdcE3NgKtZFCyYLUlkhkpwC2qEjCzs851ZWA4B6m6sdNYhyJt7VamwyHihMiAs3hmHwBRbMVOClNT23CNKPJEm7mC9APoINRQj5McBhNeJQyrpuQpkkaheDO8kVCqldT3FTkzB25KQ7u54WHsZizBn0wrssFRr4uWo7xxRRH1HJ9hVJTAPOAy+cSzO6FHlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1589.namprd12.prod.outlook.com (2603:10b6:910:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 17:00:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 17:00:36 +0000
Date:   Fri, 28 Jan 2022 13:00:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org,
        jared.holzman@excelero.com
Subject: Re: [PATCH] RDMA/siw: Fix broken RDMA Read Fence/Resume logic.
Message-ID: <20220128170035.GA1875132@nvidia.com>
References: <20220120143434.2332-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120143434.2332-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57d635e7-de50-4d60-4ffd-08d9e27fb44c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1589:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1589D158A70B6C236D97C8B2C2229@CY4PR12MB1589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6jLIvAWJ1cNpLSYgcAb9LPTSgKK0xl3iMCxQ40axnqNzPHgGi9R/fVbENWnd+EgDDgwB+UvUttKDK455gz8zGSChHeDHjWt9ghrO0dYFHAcURDeihWh/rgqJcijxRl/+S2KwuQq0vl4v78y20/Yb8v8egX+tqM7gxLsdVf0wMDvCk4G59nx7S0mWdY3qhQa1epXRAZ3QSU0fC4aSbkVdY4raMslSe11GXn52+j+ejZcpYM5FNPHJs9vgqVns61uoGtuoQBj/7LdSj7DeHp7FL3MLkKDiV36gZtn5Obs2+gSlVuT3YA+35iwELvuznrAOlALtstW97B6Bkt+HtMd5R7nFDAZjhWzL3fx/7gtaI+Al3Ga0clTq7BgvOxNhfCPY2Vghu5cCZnqI35v7sNDREyhNYZQGJebqAfcfr8udnD70QYHqMN7cxk7d1TO5Wko0yTdZmgRce6wZPnBCuv2UmuQsHo4CxVkruvEiXz2etHKLPrVzr290p0DpsT0CAEJSFsJ9nm6lp1wyZnCN0FvkKKu9/Ifijwh/WvR3k2ol5FBHiFfHSlaCkgCUNFvl6ZhQK3iwMeqcsxPa8CD8Q4Hd2A83xGYOpiKNOVxg7vxl9STbk8OwDgkZW+J7uiDzRDeCAH65vRTVsDPWbzzPLDC4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(8936002)(83380400001)(4744005)(1076003)(8676002)(2616005)(4326008)(66946007)(66556008)(508600001)(26005)(66476007)(316002)(5660300002)(2906002)(36756003)(6916009)(186003)(6506007)(33656002)(6512007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXwG4jzlxFEtXXDkjonfykSED3Yo91tGjqb1ppZwz2rnuPxKuO9fBcQmUTFq?=
 =?us-ascii?Q?DcPfxL+KG0vBAsPtPkrrGxaUQnsYlncrL0HRutsJQr0pw95nhhCtyiYtuMq2?=
 =?us-ascii?Q?OeirZA3gWFtpRgjbIhcRR/0dIZ9oqp2IeVKjOaxgHHntKQfrjIUZOEY99hZn?=
 =?us-ascii?Q?9BHwq7KplXTzkv6RP6oAnuQZIkyZK4ROcIuLmC9XdkCBpNUzwkbyhklZ2kZE?=
 =?us-ascii?Q?YbQDcJ51WcyzQqd6EHQi3mylPCc3KZyBP557aJyPi0vuTjeBHeGKmynbj9wF?=
 =?us-ascii?Q?D2D2L5xenL3vj/mulgVOv+8uY2n0K8BiyV5fcQ5aVYznpPMi2enYPrl3tkuw?=
 =?us-ascii?Q?bwqy48Fy//BO4G7lDrxMnQwfOp1GCt6O2fVvNux7ltqRUSGwRR33Vux+eVIC?=
 =?us-ascii?Q?6avWcy1sWL2M/axCpO8ZutAb3FikIvyl0iSz78k+P+v44y0Bu4Crg3s3TFI8?=
 =?us-ascii?Q?ApS271FWa5+oflRdHVrKxh65gMwCdYbdQWU8RZePy5/Nle8ksrIjVADAsqaJ?=
 =?us-ascii?Q?81756+DMkQnT/LAZ+fDMtpZeegQMgAf98DE3IyYBQUHhaGpTddJjyf8KRo8L?=
 =?us-ascii?Q?XFIsTnwHwizj6iYuuzmmwEAnQB99hp/eLHIdW6YccGuPskf7kO2yQZdwxj61?=
 =?us-ascii?Q?NqIqPKrMIzPvowtGO3SksHv5mXPR93v3ZmWw3GV+BC6Qh2HBk4c1cz+3IhLM?=
 =?us-ascii?Q?Jgn/Wd35yNHsR0l77kRDRM8Wb40ooJMb4KWevhmDQF0NXB0s7pv/JqpEm32s?=
 =?us-ascii?Q?TJolexslmqksU6yYCI3bNDiOaApfTLZWqLbHolivfERzlWDxK329gQQTsa5s?=
 =?us-ascii?Q?rIrjxTPq4Z02oN9pP2QM1+RIrg/Czi3omdiU1aaxhAjMhhnWlhqY9kxkdts6?=
 =?us-ascii?Q?2EXdEJAL2sCQL7pg/aPJh79n2dbWkgBDwpybFufnwq2sFJ2wcotvnSXNnROs?=
 =?us-ascii?Q?x8/D4wrXfpLt5i9OTR2QXXA2RhV9EqWKsT4LHIoghKzJxJ/bpfJLoy6yLqbz?=
 =?us-ascii?Q?z3pvdvK7lwXNoL0fIfqlHl0BPGdDPyYX5esIhZuyASmYriP+YVdCY5jFYbF2?=
 =?us-ascii?Q?RUxt3dZOt2Imx1pAUvVKg9Y4LxVBvLhiJ3SRIqE04J71N5fyS3pER3dCwoaq?=
 =?us-ascii?Q?VcUlMozKnTGnrucm0k1s+6t+BH0jYw9LeBUoEruaw3qDOONQtjckHHi0xSCH?=
 =?us-ascii?Q?ujhXp3q0alXfjINSHHg8fS9dqW4UDoMohdSjkSErkA3rgWtVaCz4zhJbLGNF?=
 =?us-ascii?Q?IJAZEAdjdgmqBe9chWlXhku/wiqLq1Bl/qph5i2EcSCiFnTj5m38Xs9lbuic?=
 =?us-ascii?Q?e0feGmXH3TR8nnkFEMMAmn7XqUQIHTAoG5gAwjAzxTaCsy6WCHEfdNQmvolq?=
 =?us-ascii?Q?cv4WDVqonCClDXHnN5ospM45Vj/hL0eVyh9ipDQUr+kUlDUv59jUUtLpPRFd?=
 =?us-ascii?Q?wHOMLEaMVduqFQKgIO13U69lywGtFcItgGvSyVDMunGsC11aqIeBdMl6TPrm?=
 =?us-ascii?Q?rCAnbV4Fd0LHPgcYdU153fcY51qUBoQIfnWNQpsOHU+hF1WXmtTFZujBjwDc?=
 =?us-ascii?Q?iPP4sUle//23A9pT1gk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d635e7-de50-4d60-4ffd-08d9e27fb44c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:00:36.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXuVpFHsy819k52Dn5rVo2Fot/wabhMkyCRGqeGY20wxtiKlVDOfgGcL/EQ4Ot5V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1589
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 03:34:34PM +0100, Bernard Metzler wrote:
> Code unconditionally resumed fenced SQ processing after next RDMA
> Read completion, even if other RDMA Read responses are still
> outstanding, or ORQ is full. Also adds comments for better readability
> of fence processing, and removes orq_get_tail() helper, which is not
> needed anymore.
> 
> Reported-by: Jared Holzman <jared.holzman@excelero.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       |  7 +------
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 20 +++++++++++---------
>  2 files changed, 12 insertions(+), 15 deletions(-)

Fixes line??

Jason
