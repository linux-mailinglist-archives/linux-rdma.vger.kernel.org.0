Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00959B419
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiHUNr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHUNry (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 09:47:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261E220CF
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 06:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRkmM3Sj2vmSw/3EOktXTEUaTWRlxeu8P2srMeOWNlnAHgUqD7aKdh9Nfn5UZ6pPZH50dc8duWZXjTFRpBlHxnHfIiwa2kAsfZ5qwEwQ2FrKIiRJsw/jI+N8O8y0sSk73wzcZ7WAxPCYKe9BsRV/RRTLyvPuQWdOvre+1JobLbFw0DbHdLvaL/darKF421Duj0d/1YT2gYlWD24Ep6RqZu34LH9GEyWnnPjxkk9XdTgzUh84Ct7TU/hc0OBmKaM47P+mz7pkf273rVP/LoJ3y+HGveYlCCJYBTX6RjYTBsrRDCc9z0twG8oMEr/CA5ZYLCx7i6+9fW1//5ZpstoPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaWcACHIhf2u7xHvxdTOkXDPQd82cSsRr14MDXZ3L2g=;
 b=S6JwJUUe6fw46Q2T6oXmrtW1xsZJf6bEy6yaU4z8PoDtmr4h6UVuxqQqUJ5EZUjjsgKU3OXqv44QMdFWgyVnTCDxJbftHMZYEygIJI7+MP5JyVLrS7PYcCjiTyk2ZbiEH8Ea/9NCtv5y6TSq72H6eRG2YMUj5gJm8PKc9mBjlySKlIFTeTeQive3OrlLusb3uXHiLmFUgRImPJvxSsL35VVbfpiY8h4ae2egGrnrNUlShnoZc5rpT1nCD17sfg384aaHCSY9TvMZnZ1hUHezeR4U521fjjoMHGnjLaPtnesBoGQR5GrCxjzHo9Ly70AOh+ztCIyz/LmFpsOStayvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaWcACHIhf2u7xHvxdTOkXDPQd82cSsRr14MDXZ3L2g=;
 b=UyFVRLJxiS3mwEeS7wJzehEbRjm2FArLxrHhpmo9+vSQ/CTGhcUYQGTMRvOwWzUGwPyhDjb3zO+ywHpQdrqfxUgrCxnG9wEmTPpsA31ZFmI37F7j/UImVW7i5KOs52XWbYz+wO/YynuCSH/PmHvmSozt9rEItzNvvI0EVI239/aE1nL0mwF3u0vtjgo0TgyEfylS252YquOgi1u7bdGNdSs2NSDbNGyTHbrD3EcMI21hgqKI+au0USguO7DWXuuhXS/2Gd3KWpSKiUMVsSLNsedtKvSQ4YT1KPGOnHm6NWGFKn+UxvFr1Nk89lCjG38+odNd1EP6UJRN0jesUGd4HA==
Received: from DS7PR03CA0116.namprd03.prod.outlook.com (2603:10b6:5:3b7::31)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Sun, 21 Aug
 2022 13:47:50 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::ea) by DS7PR03CA0116.outlook.office365.com
 (2603:10b6:5:3b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Sun, 21 Aug 2022 13:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.15 via Frontend Transport; Sun, 21 Aug 2022 13:47:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sun, 21 Aug
 2022 13:47:49 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 21 Aug
 2022 06:47:48 -0700
Date:   Sun, 21 Aug 2022 16:47:44 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <dledford@redhat.com>,
        <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/3] IB/cm: remove cm_id_priv->id.service_mask
 and service_mask parameter of cm_init_listen()
Message-ID: <YwI3gG23YhD2zg0k@unreal>
References: <20220819090859.957943-1-markzhang@nvidia.com>
 <20220819090859.957943-3-markzhang@nvidia.com>
 <YwIYXI9xTSpw4Vtj@unreal>
 <8863ab45-8b9f-3f1b-32c7-2c8f7e06b8ea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8863ab45-8b9f-3f1b-32c7-2c8f7e06b8ea@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0f7ac89-36ef-4476-d67f-08da837bbcfb
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6337:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of5SGa+3luvXFH2XpF7yxga1J6NlDUOLasdVkFbSRaHyyKw1nVSlH6iDT07sAqoTzcE0wkGMk0Z7adt/VViIqBthc7aB8QcyilbIq3DYOyAlAiDbKJs1M2dmPq4eoee8BWwxSF6XuzYi4aZPc4yz0CZra5zEP4k/zo2hE3rfHtrSbXn9NGz0L3PrcUZHZGFCQr6txuqBB1Gysf5Dcjpoyz2OcgFjWurAh6sXt7T52T/DnTYcXcFXQ3dB+1Y3AUYSFQnfukCSwIRvwN7hZpKk5qRdSMbO7S8NWVgawZlpXD3mXzEFVMyU0BnjoiRsyE6tkiSc+N+P/p2HpptSdZLnIZNlFWwiK7QRhpNxvPKGkoqSJrNiWbC8IFYJePa+Ydjd5EIAbsSeautQBYeW/un5mbo+U8HvbpmJVtcepEhMrpAOnh4g1mSt3yJTlhkCMkWMeNIfqRXvlsynqJPdfHMeFGrt1XqdGWynZfMjft50nkCmRV+vFUh49UCtT4wIu44JbIE9NK2GJtc9nUS6WRj5n3q2djcI+I5WvOvoO6QZlUlwPeFBvLEWH734WTykW9MwUwUaV9ntuGqzo2kPtBF7NFz9b0HKHBmnZnUsUk1+clLITnLCR8MBWPj5R8EEZwX1j5NLVoqjliYOVDbOSRkeNJXJJuXR579nszjWmxMG+XkJS2EBXR8T/RxLSQBuwmlOc3JruGeto2xrkczN12oz4qbKR0reWTxiBCOtLcZe2LS0dRvMEoSfwF5iuQbX1gPfgl2uy1BUhJvW2Nd7WKRLOtYbt8Y+5nV/jInUR3r6CHkhTWvGM/e3FxP078L+lfNW
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(376002)(136003)(396003)(346002)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(478600001)(336012)(186003)(426003)(47076005)(83380400001)(2906002)(5660300002)(41300700001)(6862004)(8936002)(16526019)(86362001)(4326008)(8676002)(356005)(81166007)(82740400003)(54906003)(40460700003)(33716001)(70586007)(70206006)(6666004)(53546011)(9686003)(316002)(40480700001)(6636002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 13:47:49.9933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f7ac89-36ef-4476-d67f-08da837bbcfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 21, 2022 at 08:50:08PM +0800, Mark Zhang wrote:
> On 8/21/2022 7:34 PM, Leon Romanovsky wrote:
> > On Fri, Aug 19, 2022 at 12:08:58PM +0300, Mark Zhang wrote:
> > > The service_mask is always ~cpu_to_be64(0), so the result is always
> > > a NOP when it is &'d with a service_id. Remove it for simplicity.
> > > 
> > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > ---
> > >   drivers/infiniband/core/cm.c | 28 ++++++++--------------------
> > >   include/rdma/ib_cm.h         |  1 -
> > >   2 files changed, 8 insertions(+), 21 deletions(-)

<...>

> > > -	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
> > > +	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
> > >   		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
> > > -		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
> > > -	} else {
> > > +	else
> > >   		cm_id_priv->id.service_id = service_id;
> > > -		cm_id_priv->id.service_mask = service_mask;
> > > -	}
> > 
> > If service_id != IB_CM_ASSIGN_SERVICE_ID, we had zero as service_mask
> > and not FFF... like you wrote. It puts in question all
> > cm_id_priv->id.service_mask & service_id => service_id conversions in
> > this patch.
> 
> The id.service_mask field is removed in this patch, check the change in
> include/rdma/ib_cm.h

Right, you removed service_mask and described it "is always ~cpu_to_be64(0)".
As far as I can tell, this is not true and in this "if (service_id == IB_CM_ASSIGN_SERVICE_ID)"
sometimes we set cm_id_priv->id.service_mask to be 0 and sometimes 0xFF....

Why is it correct to remove cm_id_priv->id.service_mask in this hunk?

Thanks
