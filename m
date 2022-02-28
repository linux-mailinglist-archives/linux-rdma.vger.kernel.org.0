Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B74C7211
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiB1RCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiB1RCf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 12:02:35 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40C86E10
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GepIkVmA6kPLsAz7tSrBLnvn+oKpVbeoM3TT7TpST7XJxsY4bhrvJRqtHswN5Ge9l7475eO2fHe4bJ7D6YkXIqVSqfVys/Y9erPv++ZfeX8LxWSyzfer0+XkA6Et4FgT7HpHS5dbaSz4INfQfnejyfjzDfkP8Kp0HAp0jCKStSsJFPwAWnFfTO2v18HEcEzeH0JJDasm7Udtocr6NUHtFecssDCSufKn2MOhbfq7pydkZtzW7Xs3BkskMOhcDl6omeFkinpqmvQW/LtSx1N6fkKVamlMMHD1t6sK0dF9nbu8VoIMd2+NN02JpyFTv68s+8iJLmB1Cf8uTx7Ttr6n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZoH4Dal/2LSKzXVhl5iR49+o9B8fVDTpJayVqTnRCY=;
 b=JULXwvWkLrv/77g2tDQnDWA0CHJBUxW+lR1WmrMYI/gQeqgVLy4nZgMDXBcwloRQAFKkh0X2kUpXViZmDQPARxN2Wr/SDXAxQUxCijiLBK3UX73FWQ78+VNLFLa/3aUPjNJsjCAhH01octVoMGPJL072vk7xNpIx0TiSbbjHR4JCcruFZnzCmyPkwmsl8cwF7oU5414gTmVM1k70/cecliMeJoa/7XmS9tOHEjqoJ7J1BwqVBo2FhSaIaKrWSdwoMH4wXUXYxOlco5s8xElOs410u/gRha5DljRXzJVMOsQDXpvTEjZF7kK63v7baOFUBRk6nXqK5SVzXcKxDWtz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZoH4Dal/2LSKzXVhl5iR49+o9B8fVDTpJayVqTnRCY=;
 b=B1NNGZpQ0mxNjMPg/iFCcTLGQ/U2AKpTrOBhcdJYhO9X/JyWvcW7Mzm1qXzTbCkW3AVbAwRUtVMapjs2yGZ/jj3TKnJr6Vp1cTzbwx+Z6gT/ZO6J1n3SZ+xoQAQDHLRhm9AnOUHsOZQAJzn4F+eHNkopuABv67MxqcWTXgkKeCc77l/unbkAGYV3HP8dKefKlL7LgJ4UNtJRIXMWr5bIglUOoTwh9ctWSqDSfiwZa4rh1AVY6bnV+f/ZtrQxoFd+J59E286kXm+5EX2qarWe7EhdszV2afi4Z0HFfyMCb4b9U86PHbj+vJaV5IFcSNu+j7gOevX1/c4CwwOUty9Ebw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2561.namprd12.prod.outlook.com (2603:10b6:207:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 17:01:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:01:53 +0000
Date:   Mon, 28 Feb 2022 13:01:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 05/11] RDMA/rxe: Stop lookup of partially
 built objects
Message-ID: <20220228170152.GJ219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-6-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-6-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e14cccf-e4fc-41fc-9561-08d9fadc04fc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2561:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25616F17B617CDA15427A33DC2019@BL0PR12MB2561.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gmquzhEGqtgIcwQyVA6uZfRZiRaUEF6soAu9kmQ65bo6wg399wcGn305rLpLWoRo3Ollz+yJV7UZjAh2qM2teFQZSIDCYuFDifmhZlz3YGpG1eBat1RP+eh4gQUFik2ESTqwFA+IEMjMrJ83YuyM/eM3HJOFEHVA66N46j8oz/gzQnkpuMRug3IfMLd7M7Oci2CWPl6ngJSQTIIQ2vxqWKgnfzz7fI34p5W+KZv2Pp7fkfFayeaEACLVB3Gg1zdLoJoo8iWcIUr1BXhLJlieZbzyibRDAbh2BRi/TJ/kVXBNWKD+9WX3+BKWEvV9iQ1rUuwCiccK4GuumjC1s8BTB1jD4/1KSjaHogadqv+l3QEiO1GdmqZZaKp5CjEpfakiucmsey8IKYKKxCxdT8RjUgcKdghZf/sI5060XnktxKTKDljGjGT4fFa+lXHB9XXKT5SuEa8f3GrNlBsRIbi2iLjyhw9v4EALWx/y/JzzVDQF/hOx1l/VPem79QIY9YsJVo3MiXOLWgKlOZWg5qGN8b8Tx5pCGo+HN+sR3Caa3XPFZ1YjVoKwFBg397OuvkNVpNIowN2bVNNKjh1xXJJZvPQvdGyR6K0LFZbDZ7TZlgAGJgRIwTZargzKP7GSlEGHggyHLPrvVo7BGjcTjxGsi03o5yQ9MG0YQijdilKfxlGVu16Rh7WG/wZwNckPjanNMvCtvGwQCXOlQy4zYa+9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(83380400001)(8936002)(6506007)(36756003)(26005)(186003)(6512007)(6486002)(2616005)(508600001)(6916009)(316002)(66556008)(66476007)(8676002)(4326008)(2906002)(38100700002)(86362001)(5660300002)(33656002)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QAHB9xxZYuI+5DrGlE5km/EgTCu9J8yGwe63royxo/6gWjKtZW3/bJWrPVUB?=
 =?us-ascii?Q?6y5SAlfUUncCeNLkNNih5ilLzFb6C+GzSgIwMNN4mR9fJwXSAOPkQaIGPvze?=
 =?us-ascii?Q?10A6f7jIEizX6MyRlEar0d/mYljDqZf2fAPxWDRMuN5YHbCAPxpcvgRVlIlv?=
 =?us-ascii?Q?PtpoPb4TgfVUKidcKq12WpbwkC4SnM3yt/uRdNxLAkzccMBJqeRAFHnbHDI6?=
 =?us-ascii?Q?Czv+01k38aG3Cg558MIxDGw7c5RqX4Qvxc9VKyS1sV4UY2UxVs0d7NSinkCR?=
 =?us-ascii?Q?/EokFJlSGpflB1wSACqbuG4jfi40BS3L2O1KYowZlWpRVP3Lmy4Ar5yNEXd6?=
 =?us-ascii?Q?2EUP26ajJayA2wjblapBtSj54gIuu+7Kq+ILnOBMRttPMP89ADPVRn2fDkQ5?=
 =?us-ascii?Q?qpR8G85r3lOFFBtXEmp40i8cWpY7KRk9+WHNwyctRCM4l1rWNhfeaMQ5rabj?=
 =?us-ascii?Q?2eA1YOfzoqia1fhg/ZT/FBWP/35luiafWznYvQMqXTTN3bO2PzS+Qjjy7frx?=
 =?us-ascii?Q?SiVz2D1jC1k6e2VAcDVRoaVk7LzR9Yh3xHh1NIneZnnIrJIBcUpTrpCpJNB0?=
 =?us-ascii?Q?HUK1uOaeKRl9qCciyk+T6EYFqZz9ZZYFsTUs4J28PrtTVJROOa7CnCgVz/XL?=
 =?us-ascii?Q?8sGkWSLJNlziW66oR0SRik/8KhwV6XQjzWADvTcISzxGAk6beUhknuvFxN0N?=
 =?us-ascii?Q?NO8SALQwI9d/8pqaMmaQCnltAX/gzJOwXXnSINZNVwCjLzXCk2tsZJDSIApt?=
 =?us-ascii?Q?QV8zw7QoqLm3faMq6N++AzfZPpTzzxN3aZhp1SEOrKgEqMay9xFy/Mv58HM+?=
 =?us-ascii?Q?zr0OTY2/iUjnMWlyDAU8186szDGmb9ATGXRjM07sBEmGCGM5FAWP9x6zyUUo?=
 =?us-ascii?Q?ZW0CiWRKnjyZEDq4IzZJVwWuYNasJmbuTXlUVPgPtjjATMrv2wGkODoSNeMW?=
 =?us-ascii?Q?3pFJKzLtkVlGWQGUBLWAY4dhPalqoNO1q82SSZwdO7GGIdLtzEyXqAAyJRDu?=
 =?us-ascii?Q?29w/h5cfBhYizCYV/73NCH711uPctYWh7AsGkYc6eEM/zxmMdo+weIa00p+y?=
 =?us-ascii?Q?Lt1HDblm13s6U1JDT3CAVikXIYyg3CWZKqq9M6lnDJvAdJqGq5EzFVKcnbo2?=
 =?us-ascii?Q?ZBU5hy+cYYmNoSAkiYsPp83FLNb5Cb13Jyp9lsUeiceRq5YoXUGhiMHWLRNo?=
 =?us-ascii?Q?Sfbv+bILOCXoM0vWQRAaXElgEnbr1ypzDflvuoU5oyV5PR+42NxHH4O4l+Ui?=
 =?us-ascii?Q?wD+YuStHopagaqDWQlG4xoiBpabItEvwb5+HWGGB4sKAWmo0e6B3vQwzmxkP?=
 =?us-ascii?Q?JpJWfw2Ykf7rAkPpRp3yzaR0GQsqGHgYfDvOMGx0pRUVe6Vv4JFP2lIzjEUf?=
 =?us-ascii?Q?9ewqxHmvoRvLPqhyb2OyQnOiUuKhCVPrCoytqn4DkKGBpd2/ySG4TKi8mil/?=
 =?us-ascii?Q?5Mj2EMatVKLggOAq4L4aWMziJbcYfHnvJBvglWpXvbgW+R8S8ui/hOkGjRnw?=
 =?us-ascii?Q?/8PG9Y7IEWvGj86orsjqan38lOsorQceOtRs5HQfaNyAGmiiRrM7no+ZIRYM?=
 =?us-ascii?Q?rC7LcVwm+2Iq+yJyLg8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14cccf-e4fc-41fc-9561-08d9fadc04fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:01:53.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TclITVM1StEsCBR6/1jW3oGRNjv2uhgID3/J+e931q8Ndn5AKmv3FiGFu8+dyT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2561
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:45PM -0600, Bob Pearson wrote:
> Currently the rdma_rxe driver has a security weakness due to adding
> objects which are partially initialized to indices allowing external
> actors to gain access to them by sending packets which refer to
> their index (e.g. qpn, rkey, etc).
> 
> This patch adds a member to the pool element struct indicating whether
> the object should/or should not allow looking up from its index. This
> variable is set only after the object is completely created and unset
> as soon as possible when the object is destroyed.

Why do we have to put incompletely initialized pointers into the
xarray?

Either:

 1) Do the xa_alloc after everything is setup properly, splitting
    allocation and ID assignment.

 2) Do xa_alloc(XA_ZERO_ENTRY) at the start to reserve the ID
    then xa_store to set the pointer (can't fail) or xa_erase()
    to abort it

> @@ -81,4 +82,8 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem);
>  
>  #define rxe_read_ref(obj) kref_read(&(obj)->elem.ref_cnt)
>  
> +#define rxe_enable(obj) ((obj)->elem.enabled = true)
> +
> +#define rxe_disable(obj) ((obj)->elem.enabled = false)

None of this is locked properly. A release/acquire needs to happen to
ensure all the stores that initialized the memory are visible to the
reader. Both of the above will ensure that happens.

Jason
