Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A7528384
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 13:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiEPLtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiEPLto (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 07:49:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7A7E0B9
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 04:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSMO1FXy8E3dv73fcgj2jtKE6mwJSLPOEa+H83aGOWi2vEOSmmk7PRq2084KcXx/6GmOaaGFCiesTictHmXuWOTSalClnw8jWrNrhF6CBj+PEfIwrnN7u6CrW2MQFQLbGe+8syktJb5D3TGYqbbhWd/E4LCSpnslezkn2gG+xUy6Fogr1vw1bHxbGBMu7tg/hYrIF8gH2PB8/cs49iBBHkAk468hLuH9/zYzkneQ74c935NJLPjquOt6l3xDb5173tDXjePL4q9qkCugRbmzt/BswmHRk+GNYrRfGOFHoMKaizoaPbwo20IVTrI4d9Akk5MU420GMSIslGnQGnxmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP7gd3scbQahZY6EdpGsLy3nBrzsjn3VJfqdhzmNIlc=;
 b=JTC+CkGL9nsoK/v41ZyE0Ye4gON2+k7jzqJvNqPxdjPwJSfJEIDly/pQXt+SvkQTbcPaYesYX+ao+ax+rGV9EOzEk+tJGNvRbmPz61iVD8UhG0mWVtWKRnRIbNWh6HoMttXQvmunufc/davTGSUAjbdyfuCm/MFub2+g/xLaczfikCEUBwC7NMdU90A/rUkXrY/JWwKDlHqFKTWyWY3droPY1OQ+VwfT86YsktFgOVfd43B0tx0e4vhFO6dDIDjc9MqqbGJRGL/EnwTrfnv4Cz/kJT00bWWUrzC3AM1o5jnWqTeLxblWs0GJB7SYJmj/f1BrdsVBXZvnbw4/w1x8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP7gd3scbQahZY6EdpGsLy3nBrzsjn3VJfqdhzmNIlc=;
 b=eSmorB1Db9q8Kz5LFqUK3GaJ2swf2W4FmbE0A3hw4QPRe1lWdVs1rDHxhG/bPbAxq8s4oVqjRPf6AVWWGwPx6ICQdS3f0lLotiOXC0fgDeL14FgFmAD6pESKtjdmYfF7V00TT/0tucOmttGcNKRW7ZRWK2H24hxProchX1J3HHVrp6yIyaueroC928VXJkKtQFBRRj6AUFKo1gLNJ+uqpERgHglXNvOFC2XNypbawQw+0Etmq6nFbCyxGmRT+Y3fR744neJ1koGMwURVyRFlG33Qyeigd/Qu7UmLl6EbG8xoYRGjm6JB8DOG72DqqYQ+sCbYFDaIEl+IRAW8WM2OCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB0157.namprd12.prod.outlook.com (2603:10b6:301:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 11:49:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 11:49:41 +0000
Date:   Mon, 16 May 2022 08:49:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Message-ID: <20220516114940.GT1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <15a6e72f-2967-5c19-3742-d854409275ce@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a6e72f-2967-5c19-3742-d854409275ce@linux.alibaba.com>
X-ClientProxiedBy: BL0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:91::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1505b5a0-1afa-4304-2c89-08da373229c8
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0157:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01577309483F7359601CE19FC2CF9@MWHPR1201MB0157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P87ObRNkvANQySVf0wn+vX5fiOqLuCXoe3z7dOH6sHMJOCfUEQl0bUh5wMp9EZB+7WFciVi+4W8oICnVGJNz24rDbOVDDxyYsFi9xiUJsP/4YwhsIMIGcvW50/7GAl6HUM8fY33Gt1jRz73CWAYhSrm1RpdIiCboX2aJCu99+HcW5YzFJVhoeF56DIxStw0ugW9guhjS4NOgz/AIAxJNpYHHI8piTf7a+Pnt5YOgQke+RiybKUf/BAlWtoKxxR483VwozxVBJI4Mg1YC1Nds8peFCQgYHXBz68kqVmdVQaa/1Q2p9TAic1exh6KshxMkhsL6j+SIJ45xZ/LGWPfY5unYyhZADEGzH/oqKPwLi5XX3izbFXkJyTCO68zkpolLHuHI/vk/0Ra0nbBSZw1rN9fP1YOsUozhG0OkSYd1Q1blpJoVdbmMcgb6Hf585C1VTPw6wxs7EmEG04AFLZJMKEYdHG92GDgAUGo/TGrkvlHUi0sErIA3pna/SJ+EOFEAFV48koQRXUemv0vtzkNCaF/VUOuAxhYk233H0Le6jhsRgCb29O8x99C8WVFR60FbUW+xhWlaEtRM2Nk1YN/UqXBT27cCvPVB6kW3BI10Vte/ZkgnGf/6ljhkQcMsFeks0M5hQBoijm5/f+VNVDLxnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(186003)(33656002)(2906002)(2616005)(38100700002)(66946007)(8676002)(4326008)(66556008)(66476007)(1076003)(6512007)(86362001)(26005)(5660300002)(8936002)(508600001)(6916009)(36756003)(6506007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dT0btDMlOAeU6reJgySSuE6gqDDaxZ5a0HAFwhEPMKgj0Uyb391MH+FxpJ2b?=
 =?us-ascii?Q?wNmDSERfgVjhTjKQe92BqsCLEGOJ6IAUo4FVshY9XWeDMc+hM5hcvMXtLaoA?=
 =?us-ascii?Q?0cmIfG68buIyoc4CBysjbNq1s787iSTDBQKKLn6YzTkVWMHk1lyuxHchzkuW?=
 =?us-ascii?Q?IRn70VIoVNycwrcJJw21Jj5O1UXpEXMDtoA3e8DclLKYTQUdR7aJSMg9CDOf?=
 =?us-ascii?Q?4lG/53lZ/09AwDSeDygOhTWjjpjSR1kS/SUcqg6z0haYcpATJky9DM1BQMqC?=
 =?us-ascii?Q?LV0Ja/mqVhndLZZGXwemvwl5OoFrCu2VmaOWy/T3aRFoWGjTjq0YhAipLeek?=
 =?us-ascii?Q?Zre+/yHH1WSkP7V03fLkYpuLPRR0p8BbVkiHufc/3luWym+TKk+kVyabZq3n?=
 =?us-ascii?Q?KxkhMn4PaU9UnkEFvdHDsUBvc8U0NnTrH1U/wmjvutae70IKyHeJIybVNLYC?=
 =?us-ascii?Q?yUFFxpIZos0lr2Mxy8yKTNn+OlqiK1vizlL4d51s4Vr88oB4X3M04d0gTE1k?=
 =?us-ascii?Q?s73haTu7Z0VNlvS9DTjcvW57YUozwVjncySgwtkXeCdxQx5qi1btgQrY3yuL?=
 =?us-ascii?Q?zCnkCEAirZfQi2b9UJJXclm3bcbZeSTThLQQreUaGbQM2DCZDudnMKG5m3dL?=
 =?us-ascii?Q?/MHNrTzmRqactSo0DGhu9u36Mf43Y8advXZt7yDAsFxevH97JRLuFsWCDGIz?=
 =?us-ascii?Q?UabvdsGwS3BcnUv9vTKSDjA8vDYOvV23aK4AS4aqLD2XmLi5hc4oaBb9tksL?=
 =?us-ascii?Q?vMql/hgWPoeEhc5B0+WxZHbAhMv6grwO9pKrjqJdcHFLTQ573J2Sp+jIcGeq?=
 =?us-ascii?Q?Vgbungr4TPYIsOr6b7NypsTu/W1QcEQaREyW/U4lWoW9SaZ5xUozMj9EY7JN?=
 =?us-ascii?Q?Da2pcWC3CrCTXGr7lUMpoEM5nc1DK3CtyMwBXPGYWTzxGqkOuZBBcMXSN57V?=
 =?us-ascii?Q?+rbqileFH+Mrl+FFdjeRAaM1UnmuMOW4xMcDWJsUX5hT7JVBU5aCgavPwh+F?=
 =?us-ascii?Q?4as7fzgJgYFTKkFFQ4xMjK8v+QhalxKFJ5Pm1tsoQt9LAPVSjTFJVxVsPdat?=
 =?us-ascii?Q?aE/xvM0u6YElM5R2X8y4S7YxLimUfpCj50a+OIvgiw3GtjaIskCpvLiPviPY?=
 =?us-ascii?Q?V6LdY8B67B/HnszVy3Uuip09NMjohnvyo6rLnTs5/s706mKlpjwXO6sG5xzO?=
 =?us-ascii?Q?RukPdauG7I83NpKNAov7oKMNg4jR3CZOinnW4QDdQguK9/tHADulMmnqWu2d?=
 =?us-ascii?Q?YiZqwSPgqTo2ci/VeSgSZdQOjoYDBWpQc8PG/TXqsPgGsHUq5Qr6piNJnrMK?=
 =?us-ascii?Q?0WGu123XdFC/+pql4eYGDsWe61WnkPpWjJEHjGObeQ6y6KL8CppANPSZdX81?=
 =?us-ascii?Q?Hn6D1SDt80sS/vCxsqPVakpEmuhlaso3tc2z20db9nEFjYv21jdunCJzuCX9?=
 =?us-ascii?Q?IxeG+Rz1PUpD+5jD6fbpeLkKZ4h2zNvojEjHg9xb0gOTBnqF5xoapDsF42tU?=
 =?us-ascii?Q?0bPADx2JRERSnwNH1ktz2D/F+t3fRueBwoO7P2FrTNZFKKsi+s+Mm5Mp10AW?=
 =?us-ascii?Q?9h2DlvE3NKaOnn00OwjtlfiKZZcdHeY+7XbucEsRBviwSiJKqG+PFIde46at?=
 =?us-ascii?Q?bqMIyTCaU86winfGQo29LgipQ6GZkbmvjAitRMVDRB9KYa8427RJkDo8IFtd?=
 =?us-ascii?Q?qIoqDmQqJank78gS+VMCcGtKM10ZuXnUymRw2aW/xCnfRyUSsHphh+kEow6n?=
 =?us-ascii?Q?dp7NTltnUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1505b5a0-1afa-4304-2c89-08da373229c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 11:49:41.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkhzhQHe7kEndl4u2VuYT/9cmQ/dgQzgLLHtStCX8XH9t9PF1k5lpWL4DIspGkqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0157
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 16, 2022 at 11:15:32AM +0800, Cheng Xu wrote:
> 
> 
> On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
> > 
> > > +static struct rdma_link_ops erdma_link_ops = {
> > > +	.type = "erdma",
> > > +	.newlink = erdma_newlink,
> > > +};
> > 
> > Why is there still a newlink?
> > 
> > Jason
> 
> 
> Yeah, I remember your suggestion that the ibdev should keep the same
> lifecycle with its PCI device, and so does it now.
> 
> The initialization flow for erdma now:
>      probe:
>        - Hardware specified initialization
>        - IB device initialization
>        - Calling ib_register_device with ibdev->netdev == NULL
> 
> After probe, The ib device has been registered, but we left it in
> invalid state.
> To fully complete the initialization, we should set the ibdev->netdev.
> 
> And the newlink command in erdma only do one thing now: set the
> ibdev->netdev if the rule matches, and it is uncorrelated with the
> ib device lifecycle.

This is not what newlink is for, it can't be used like this

Jason
