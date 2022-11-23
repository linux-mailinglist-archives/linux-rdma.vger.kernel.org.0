Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0B636A0D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 20:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiKWTs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiKWTsz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 14:48:55 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB2C6712D
        for <linux-rdma@vger.kernel.org>; Wed, 23 Nov 2022 11:48:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QedXSscqSb9YnZlmJ/DGiBwyw3tzVqnGxxrtpQXruuY129Qe0wZ4wKYf6h1r2dJ/MS7X3fblPB2lAPRGPmSy/F8eHeArm2KlvO8y6T4TF/K6OOvQDvY8WCUHuaUm5lrWvZE8Zks8TSDCOMemdKOvj2W1Ssuz8XaZsIRXDvl9lTNuMaeWlIu7jKOaceQlB6z++uU+Gqk27MmxrubavyMi378gJ3ax7zXMQmetcpaHrMbz1NYcEv/nChVzjciuWbpiC/2rWu4AZo+0kXVYitJJj76vDIQFcHW99+5FoOCiDVW14mX3sBni/NZ9Xt36jqcfLBLhdF5y8jscQxGr8nqzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7TZ/VQwMjkRBR56L8iucjLKUlbZ6gK9zkzd22UEjQE=;
 b=UQXeKMclE4NQxyasBfqDBBQM8mgMEidvTtwVbz9PRN34oY0UgFeLhdSdSlmaVThWmFHn4NSaP4ega5P5mN2uZusyXspuQGcgdrYdkO29eIpj4f5kS+mWzQ72DtEFI7GVpme8ZELMDIqRWmorloMkHu+K5heQk4jyg0bVqjqGhx6dXfq/oSGwydvfgWFS5Hek+p+gHpvq/pYdBQhoPf5SYlvF8pUDc8FTjtlJaBHiqQN89GWvbya5QerUZ/djQDypSIg+uYJ7+zTOxeODmVs05qPtKrP/EKEeLiV9OKV9abRFqHMDmasKBVLkKrDyZHFcIqrSc3DgDmk7cZ3J6NbCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7TZ/VQwMjkRBR56L8iucjLKUlbZ6gK9zkzd22UEjQE=;
 b=QH5de3Lgt5JF49TaKbYpzcFYG5ta0/ZNQN4NQa0UFXq6TqRMgGeitOr5OdT/akumS4QGbjm6Bwh5M06eM1lV3eLMgtGg4334z6HqUTQWEAjI/XPhf/9DtiqpdJZo0I0KqhjmUpui/s30zz/1PTi422pMA6Lp7wxRf6IhkuKxR3DcerzG3EQ6utgdK8WxxPoR18jdwpdYjvPx1Q+xsf6/mK6wPwubxRoNJoYpZhbSGLo6c9QIz4O2ret+Lx0AZPCoHRfhUhkVxNW7R7p7oPGd0aPoIYsN9tLTf1ymWJz93KVVG1V7S7/b48I8jRHoQsFcULjtXL3IcDIy3koBmKcqvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 19:48:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 19:48:52 +0000
Date:   Wed, 23 Nov 2022 15:48:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [for-next PATCH] infiniband:cma: add a parameter for the packet
 lifetime
Message-ID: <Y355I/a/62kl0e07@nvidia.com>
References: <20221122090206.865-1-lengchao@huawei.com>
 <Y3zX4RnA5yrZHaqV@nvidia.com>
 <b33b0ba8-264b-340f-071d-7494c958b081@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33b0ba8-264b-340f-071d-7494c958b081@huawei.com>
X-ClientProxiedBy: BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bec6d91-aacf-4163-e9bb-08dacd8bbf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HM/v6x0rNwTpzcsdAujTNH1CSU9/8EwK5gqlJ4unOqxhfu260AYbOAoN57TY/93WsjuOgRYauba+Hi+sHt/U67SmpIlxiHbWELt77m5S+WKBy9uPCAKUIvkB4yc5hWyoR9tt736IdRNAmYd5Zn2QOCTZnnkSmzSZVlA66RGE8NIVa2yIUeCMEEmrwouM8YdwUYCxipkV6m4/RXKw+z65T2Gqdj96odvJIXSOoCADFJPgBCX/bJZ/U+lCAPVfMZZg42ERlYiPQTN5aBGkvuCQqGZ9VVPsRrX1fgBTVTgOpNgFsKNyXYSY5tsjJBl8u9j1x95p1Y1HQOj2W/PyLK2AoEtS+sx0A4P/4Il4T2msaGyzlpJHmsQiuyoM7M+9YZV0WnuIbUDzsiuJvyvMdBGcfZS5bYuK3iPqgvWCS26fYwFAUlUmISgiEhiTBK7ABOwNeQHEk2ttQ6HjXxOEB0C4qorgTbmWev8wCw4mPCZjmlE4eklB4NhdY8D8DaGr4Z2Wa1s0YIaqZZjfGqdT9+y2TeLAzC6nKepM5+pWfmHvfCg0zGjYRP0Bk/lM28p+mWpE/xwQMCskV4/ofDUxswFUJLmChxmdvWV7QQREIHcRmWSuBiKY/gfczh7gcnCpTT8FVtS0m+HhrMrkZDhplke9ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(66899015)(8936002)(53546011)(6916009)(6512007)(6506007)(26005)(478600001)(36756003)(86362001)(83380400001)(186003)(2616005)(2906002)(6486002)(38100700002)(316002)(66476007)(41300700001)(8676002)(66556008)(4326008)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6y58IsZ4Wdmvg0u2wJ41SGrlHP2xAQCPyTkZr5HrY89nFKQoyDSsFL+/VR0T?=
 =?us-ascii?Q?a74/21vswlNOLVcPexWA7w/dS4m/SCEk6T241JTHGz0E5VbJRGYq9epwe3MK?=
 =?us-ascii?Q?b0N32Ouaty0e0sCf/ed4jOVz54t0d5v+yErSICG4EVBchtNYGFKxU3LaSulc?=
 =?us-ascii?Q?JtZLAoobmy+uXFzg93nuK3ZPhk7Lzd0IKahos/wKOzR+YhWYcYUtycPhIL5+?=
 =?us-ascii?Q?vnTWM8Sj9bp9DKKkdEckgIBOGoxKrOv1H6Bk7yb1c4Rmm0Svu6U6lPbRrwiU?=
 =?us-ascii?Q?Wk5zzJB1mjSYjRoGv9uLtpoMVhjTi0EborH5EjzR2FceOIP4vyNGfZ+lyWS/?=
 =?us-ascii?Q?dG/i0an1pIE1tqSR0Sxpuf/oxkjLhdyCpiZgKIDrZCvqqBJbi1kYQX8R+kZ2?=
 =?us-ascii?Q?Nyep2RglCZTyXy0JV1jAUpKQhlOme0vU3bX5Yuwc0FR2xojWZ/DIA8QXxTOk?=
 =?us-ascii?Q?EMu/zYIhyz8j4NgpNQtIvQxjwnK0GQvSWNHJFCFaLWtw0LwCeV69IeRkMNci?=
 =?us-ascii?Q?OLXUZbe+sTp5W87E1bwjMUpa3CEmoUIOaGCqGNarWwYoTGvVkf6Y/XNgGL0O?=
 =?us-ascii?Q?+z6+qAIXadFH4OWmvzI0Cu9lM6sc6PUuVca4OrfSICOPQmY2mgGllLLoW+p8?=
 =?us-ascii?Q?DF6sTlMusyn3AA80AF9Hi6q4k5KHv8oddpf1hgIKS4KYZn5FBLi5PoQV1Lay?=
 =?us-ascii?Q?X1Tp77iZ/M7M/mqdHkFjAK5Vw0FWSMFn2HNfaKuHd1VcR+MSzUSCMu8XzYzZ?=
 =?us-ascii?Q?D+sv76QN3Ni4CVnozQEQcoUTqcxVWjluXtGC8glozzVp3hNxDgC84r640Fyi?=
 =?us-ascii?Q?/YQ4fLsObhR+cnCW6PBmmPafdZtOcwIY43Qxg+rmvUOU+lMZW4LF9Wfn/1QC?=
 =?us-ascii?Q?i0pztZ5wTsfsuglUczazgzwTz7iSZ0YCbJorE7WLojUJ2/bo94Nx0Cl7eXfx?=
 =?us-ascii?Q?yixZlhm04HfSpr+Q3qYU00gKUJH7VyN5/2Clmom5pdi2ZHycpSxPo6uc8QAD?=
 =?us-ascii?Q?roy07/lQljTLhiR/xNRqAvGPrv83E3IuOJhGtFCqxZfw4bWEIYNvxvPTWfBC?=
 =?us-ascii?Q?dryX5CJfIIwYQSyqE4OckCbtRnudxt1nua7Dh5h5wSVWzgHM3neqeNcJAf8g?=
 =?us-ascii?Q?Lywkb8gSWdHkwm9Qpy5SSib4+9OjJum7HUmFy3LlVEor99NvJKN+zBjSSF9E?=
 =?us-ascii?Q?LGjrUNkEdFv1c2J/wnYrVOApVvz9HuThcpsT+tNGJR81kml1+d3pWaA0qSLy?=
 =?us-ascii?Q?r/o5KWUMslTWx2Ub5XmrC5/dGdtU3uLQFoBgDRs+SoaGeN2wIfmuhyydZI/W?=
 =?us-ascii?Q?83CP/nAaNgI2FvfZ2hEQp5VDxEWpRzKLzfjecVl4KpIsRgziM7LzHXF3dmM8?=
 =?us-ascii?Q?Su26lfMXk/w0RNtS7akSboR13uaJ/YBp0295ADXjDAParHhrnrF6bCgFgR3J?=
 =?us-ascii?Q?TXYebhCAnqzTEaMbDkHDjDpQCYYTan4XumAjcV94gm1as3iaLaoESkfbd0N7?=
 =?us-ascii?Q?BTQYJsZBWDga09qeokzWyoM9RsUYHPOg/OVU4Qnk89C1n03WCi7ljEgoL3FH?=
 =?us-ascii?Q?etWoZywfi/B+zhOuM0k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bec6d91-aacf-4163-e9bb-08dacd8bbf94
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 19:48:52.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRtjtrYyQ7Q445xax3ixLaN+hQn/A8O9iTwJ6hnLlBRlebsRuoOuvAejGfRa3AQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 23, 2022 at 10:13:48AM +0800, Chao Leng wrote:
> 
> 
> On 2022/11/22 22:08, Jason Gunthorpe wrote:
> > On Tue, Nov 22, 2022 at 05:02:06PM +0800, Chao Leng wrote:
> > > Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
> > > That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
> > > The packet lifetime means the maximum transmission time of packets
> > > on the network, the maximum transmission time of packets is closely
> > > related to the network. 2 seconds is too long for simple lossless networks.
> > > The packet lifetime should allow the user to adjust according to the
> > > network situation.
> > > So add a parameter for the packet lifetime.
> > > 
> > > Signed-off-by: Chao Leng <lengchao@huawei.com>
> > > ---
> > >   drivers/infiniband/core/cma.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index cc2222b85c88..8e2ff5d610e3 100644
> > > --- a/drivers/infiniband/core/cma.c
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
> > >   #define CMA_IBOE_PACKET_LIFETIME 18
> > >   #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
> > > +static unsigned char cma_packet_lifetime = CMA_IBOE_PACKET_LIFETIME;
> > > +module_param_named(packet_lifetime, cma_packet_lifetime, byte, 0644);
> > > +MODULE_PARM_DESC(packet_lifetime, "max transmission time of the packet");
> > 
> > No new module parameters
> > 
> > Maybe something in netlink would be appropriate, I'm not sure how
> > best to deal with this.
> > 
> > Really, the entire retransmit strategy in CM is not suitable for
> > ethernet networks, this is just one symptom.
> What do you think to change the CMA_IBOE_PACKET_LIFETIME to 16.
> The maximum transmission time of packets will be about 500+ms,
> I think this is long enough for RoCE networks.
> 2 seconds is too long to my honest.

I don't have an informed opinion on this. I agree that 2s is too long though

Do we have any information to back up what this should be?

Jason
