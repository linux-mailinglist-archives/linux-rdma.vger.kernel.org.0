Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28C6798D4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 14:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjAXNAT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 08:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjAXNAQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 08:00:16 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669102132
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 05:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeMoVoYV1fCnM5GqtkXOxpZcoUnR7DM1GW/AcI9nigYNFPEmmi9ZL8z2UoQDK3ZJRxRESOPOuJDuJb6jvWppfDUC8LuprU/2v9EI9+P85fXmdbV29pAnkM3mYKzP3M6Hc8BuOeO0sU0wOuv9+8w5pTqh29Sz1Xnuk41UDjcezfaa63wxMaDH6pST3Qp5iPjRMAJCzaHuGRab35rEUjnOC+6/0BhFAR7gwtUosbdOpWk6uGLy17q6uSsP5d45a3H1AfzqyPrJrhZwAvO/7Qfd1wEckf+hDAmMp6K6hoksVWNrlbF+FvpNoYujzlFO76zTHh4Ip/RF3FTbMSjPBM7mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwWXCJOYqwIey/GOl4T5j4SgXwuT0+eeNyYvHYRQ5d8=;
 b=KpW8iRIMKm7Xhy3t6ht63oe9bHyIvpOcCgB2xoS3XWIsCpO1OZdCMij3o6f78bchfdbSwbcTsS1DxF+At8RCzINQ8YaJYSv7fR2UpPhc1TX9kV49PwENruJEvCy6RTWeevTIjD+7lEwkyeMNZvMHYKssUGhZChhYsCwxu1+ezTfU68SHhAFMK4hg2yk8WKA8a8o2WIbuMrgqUKRIjPzBNUT8pYuU+rXTCPqOML5KglKsw9wPuj4c+Ic9OAjNolLrcQfNs0Sen9DYzeGR9rVxr/5q97NPw3H8VZ/52qJ13AOB7IqTj45p+NedvFJPy/VP/e6aIWFUd82w/xZsdRa4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwWXCJOYqwIey/GOl4T5j4SgXwuT0+eeNyYvHYRQ5d8=;
 b=ld/eVuaaPtNrIb2rRTxmC6tX7soEPw1JnUITwB/E5qFMcF49U5fMS0Q5FFYBi1XypI17ViPxdzLSWRue2h6WxhXP6Bj6+fUgq7SCa+bGNYkLdz9oByW065tuJJVa2iq+DH8KjMGsg4WP4CSX0IKZhxeSCw1tAhfTE6l9OYpvVbU4FJCYmVGw/P8xIOLCyobgeL9OlnbRqVAafPQg/Lh7LfDtJtaXmAEgx2rDNO4AjoP1NIKnkprWMPrpbz4pRqMzZiZzFn160yM2cpEwpiZwKbrwLymz7nA5wdSPn8HXbQvZQjaGrYVR/WLCrR5IoPLO79f7kG8ZmwWUynlweTW2Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 13:00:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 13:00:13 +0000
Date:   Tue, 24 Jan 2023 09:00:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] IB/IPoIB: Fix legacy IPoIB due to wrong
 number of queues
Message-ID: <Y8/WXGp55biPSe2i@nvidia.com>
References: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
 <Y8r/BUdb7XMxwVN+@nvidia.com>
 <Y80vs3KQ1QfB+KBf@unreal>
 <Y87SpbbdYE3A+y46@nvidia.com>
 <Y896PRioqqz6nVCZ@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y896PRioqqz6nVCZ@unreal>
X-ClientProxiedBy: BL1PR13CA0387.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f5dbc1-d83c-4d81-6419-08dafe0aeede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3POMw+bbgtWWpbARVvak1odsbW6sTRHXYcvmlVhmGScrb0Lnf38Kca+7Pr8aGMebDTU1R74LOsjwaQ5y5OIJPFLzscXsBDDB4ldQFx65C49Vpbras1P/6bMT88wfL1qj27l84SSEOyr7KuQZEr7mFYb9oCj28fmtmJ3Z8WHiChD9neUXrxvhM4U33vKPGbTrOj4eUeVvJ/CohGLRiN0RcE5tp/XOrIzqaXBkkUjdYyx20QYwXiSUqPOiFYi5REe6c4VT9VIgpL8PTEkuFfaqUWiPY7OwAkSrfSyCyemop6Ajf4686uhu+7Ch7Apgu05UaqRxPsOMg+TBNzBioeAEO9anQlzbLZtOmorvCMBOrb7OCSDUbBIkr9N9AKQ0xPCPGbFvo9/ClFLnRdQYlZyyiBeh8ku1sqWF3Dy9pD/eyI+uDzoM598797s61hdilxUb2q2dlnEHjbRJK70ZcT4PUKRVvLEyKHTaBJnhc1tYCzQHYjYlezwG3XxSTDBIkc+L0XcXWoj4sljbJrDo99SydasfGYwBBR2zWZWgSNOa5x4u2vZ4ksqFItM+u/xCjeW3FKi3ano15SwOGMMFdrmzLiwgrjGE08T6Ya6RF+8BVAOSH3RPoT65v94QdNPWnb9WaAC1PfUR4NuyT1Jg8PIYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(316002)(54906003)(86362001)(2616005)(83380400001)(8936002)(5660300002)(66556008)(41300700001)(66476007)(36756003)(66946007)(8676002)(4326008)(6916009)(2906002)(107886003)(6486002)(66899015)(26005)(38100700002)(6512007)(478600001)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdA2HL30DWOA1qDl7S+tBKIFGNV0VsaR++oUKyT/etQyfxvsPHFKKYSAGZ3u?=
 =?us-ascii?Q?7EMisIowNMZQWp6tfPXJGhe07XtSlO8U2YUBaJbuS0kSHJbkycoHny6P/rCD?=
 =?us-ascii?Q?veIhzr7Vs/kYLHoa64h6ybT6ccYbqVbRBTMyhw39spNvYDWnw7nZ+ZeD2g1r?=
 =?us-ascii?Q?q3rrq4mYYl8Y2sI1dxvHjDR8wk1t8yVpoL74Jh8EYVcDMrz+prF7QHJN2CYQ?=
 =?us-ascii?Q?eR0uAjGUPtpeqoOT0gShrue+c2QT+mRdo8qZ2iKflSvU8/pjTAj4eAObKWmi?=
 =?us-ascii?Q?Rlb9bXQTktxoDuiE6WFAPgL7LI3Y+92mc+/x/9u+SvM521kBN+9hpeNjMZI8?=
 =?us-ascii?Q?Jd5yYc4ySpnjbWCgUkf9Uqwx21RaaANON9+L9iLHv2l6cTKbvnlCeSupwJ6i?=
 =?us-ascii?Q?LTWHDdYpKZyJjPKdA6zRoiy2yd6MCO4cctm84kiWVpglP/qg/IWFUdFu1luT?=
 =?us-ascii?Q?FzJXIe3ibdR90Isajq38Cu63bLn3oRZwcDETl1Y/rBsmvkxiUyL7Ej1SHDF1?=
 =?us-ascii?Q?+dIsHyDgy1RPalTSzRrRpezViIpD+TmylxJJIN+Md2kdSm0f3X0e2ezj8W9/?=
 =?us-ascii?Q?3p1XdBjY+38fikv6OObxyYpa+c2JiCTOfnlrX3EaO8tCiSjMYxclajm2OKPb?=
 =?us-ascii?Q?4eCkVifyrU4lJh1WinJFVBEnjnar+FCtJTsJkYlMbB8KmqCKSf07nPW/F+II?=
 =?us-ascii?Q?l/Nbie0eSIBRrZCnSpFzcYA3isWTLZpIwGv1Cb6m0DYoZAaG46tQzjCUiCCC?=
 =?us-ascii?Q?T1r7uU2GpovBOHx4CPTmu92l285PfS/O0aqIA3QkiuUJX1Ti/y79ofCB/RIT?=
 =?us-ascii?Q?rIZLzVUd6Inglvt6DycTlCoU72naJJE9LN08Ozn/pQnGbRm/l1Ai5Yoim9vF?=
 =?us-ascii?Q?aVsdKsAtvkEueVmuDHMLsTFDkwA0XBiuQyNvHSLnhGsUurx+kL4WOQLJLm5V?=
 =?us-ascii?Q?UQ/odrdnTTjt485T8KO+A/ECfVifWOPpEvg/o3e7mI4DkY4kjW9+lPmd4KIA?=
 =?us-ascii?Q?GNuonRHstTtdPI9Ljo0YvKJ7I6+RdG21Oz5texk85CGhum0ZyYwH25wFatsQ?=
 =?us-ascii?Q?CGK465dtgWqNyTH6CL+uJfbwaOeiyTpoN5w3XmyORoIVULL+OZu/KTiMnql0?=
 =?us-ascii?Q?g1N8dx4HQsu2vDBDmzTL22ky4E/OukEgnU1YaiC2SVTpaRsSB6BtO2aOzMfA?=
 =?us-ascii?Q?qBGhRgEkkjN1pgZz9YFzZ2cVvvBHg8ltlYAJ2z2J52vxCDDyTYh/lsoN5Srg?=
 =?us-ascii?Q?+9skefEkpZjyJgJWLyw03hJcTbpZIHXf21/aDUXdoATFDGVDX5rtTWbNUoP3?=
 =?us-ascii?Q?hLCezgVR6xbtwrIBRfMutWcqMLmEcRXYdlxQnu0BFX1fMRLFpOWKeDgw/TiN?=
 =?us-ascii?Q?WyEg60tCV0mWcImZ8KxXIe7Ksj3IR4rkngV15+nqcf1ED2Nw9z6M23aTb1Ne?=
 =?us-ascii?Q?i6uWe3aqfZtfOvQM5Hye+MzAj7S6efpNMpfTgT+BfC03abXRlZgdw0ZvheRh?=
 =?us-ascii?Q?FhqbMPkFUjzahKqP/KS00o/RM+jK5rDlJLbwog6T+K4S7rC5ZBcsa/g3g6+Z?=
 =?us-ascii?Q?JeXLjsBQJBKVPbE9ggPps3TmCaiAoe/BA+W7LZ+j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f5dbc1-d83c-4d81-6419-08dafe0aeede
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 13:00:13.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYg7044s1JgQ+O/W01Jhfj7kmQ19ZeOjQPti4qh1DTgw4Q7JOyp1WauWAQ+1krfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 24, 2023 at 08:27:09AM +0200, Leon Romanovsky wrote:
> On Mon, Jan 23, 2023 at 02:32:05PM -0400, Jason Gunthorpe wrote:
> > On Sun, Jan 22, 2023 at 02:44:35PM +0200, Leon Romanovsky wrote:
> > 
> > > > And the return of a really big number from ops->get_num_rx_queues is
> > > > pretty ugly too, ideally that would be fixed to pass in some function
> > > > arguments and obtain the ppriv so it can return the actual maximum
> > > > number of queues and we don't waste a bunch of memory..
> > > 
> > > .get_num_rx_queues() is declared as void, so it can't have any complex
> > > logic except returns some global define.
> > 
> > Well, yes, you'd have to add some arguments..
> 
> Jason, please be realistic.
> 
> We already were in this place, where we wanted to change netdev stack
> for our IPoIB deadlock. As you probably remember, that didn't went well.
> 
> I see a little value to change bunch of netdev drivers just to save some
> bytes in legacy IPoIB.

Well, then don't do it, but the other stuff still has to be fixed.

It didn't look like that big a deal to me

Jason
