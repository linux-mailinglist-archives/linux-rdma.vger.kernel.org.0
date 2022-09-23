Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C865E7B91
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIWNNy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiIWNNn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 09:13:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F2713EAE4
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 06:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ5HS4ACH2oZt+nDJmRviSM3lc/Yk4tNkPYuX1p2Q/gnAhSDWINP89b9VJBBP9h8ghgFVlqg3ILdKwO6sqRfi6Ety7gnMDAfN2prWANHxlB8OuVlV14rjN/7GaqzpSPjDHhQbeUJojSnwjmtCrTQ+vtNfZ6Vi36V/YRurCcWSVbXRnxfAd+J01N8gqWGmIe8cGKXTYqyw2zjITNi1Pq2OkldPVEn5/yv+aTlEI6xd4e/0ee8NvrwLGE3n4e0sd4FiXNKHZDur7giIfpQdRl6HycEjkFPsksd15EmYWtA9IbRGmAbeAk13OKk4D+oFC5gE7kHdRh5aKl0Js3rbb+CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TMda6ej55gteSNYL2UjncI5wovCnmChsW9tYjuV3PQ=;
 b=eqVwh7YlnKI9rkzYBpXsPNZuRVl3wPv3K4oC4Fb1n00llxBjOQjjp7ub9gyM6RBobazd0NNa8AXO75tuMaMDhQCFJFTA1Mi3uZe721mruPB10RRDcNOijT/bJIGdK0cgfjtvNNhjtqgM0OabltbL94RUbr92MKbF2aVQm7iPY2vGtCrRC6huaHS/hpcfbiJHCile9sWkgdR3/v+QdoU967SPB0dcUUbmT4u98nxpcRVIl10W6FKKa8Hr5EzXr77nAtkKtcfb89Sc51yhLlv0PCT47faAIqkDZmKOGy5VmYwteW8kSLxl4Md6ek5SnX1wOwu0CvaouXJry332101XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TMda6ej55gteSNYL2UjncI5wovCnmChsW9tYjuV3PQ=;
 b=s/Xy9H6a5WsVERNegy34VPaG14xHZ4750WoUxzpn7ChI6dS7BbDtP/v4MQR4LlDH8CHJur8vqjL6+ef/yEfc5k4X6F8Kk8tqcIQehK4Li94jnA6Ykun65PKoVgdvmtPulgRH91krs7s4YFSequU31W2u+4n493vb2InMtqxKXrRT/+uHUvsDreiAsYYi+i5hMa+OecydwRNLZxZVcIDqDcQZ8lHYVWPSoIFxZLbmF8LB1eoSonC9fc499WxHq87sCwrCDuZjTGUiZfyn2kGKubcNmfEnDzI5+Kpoq6bmVBK+I0u5oVFOUPNGd6/Gt2kOZgR7o4Wy8PguScovCBur8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:13:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:13:31 +0000
Date:   Fri, 23 Sep 2022 10:13:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support
 with netlink channel
Message-ID: <Yy2w+kxp7ebtsdFE@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
 <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
 <Yyxp9E9pJtUids2o@nvidia.com>
 <969cf0aa-a066-5142-d917-f07130974764@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969cf0aa-a066-5142-d917-f07130974764@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcafe38-4280-4a3b-478e-08da9d656957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBFLH82rbc3E//zIhPyXUxFyIDK+K948y5dR7w8HK98nmMctnxzoftOD+UgQdNhh+5jcjDMzU/KDSLNBtN5Xq8ouhzrc55HQZHgC4deROtpm0jGAwLsXz1LJO+rwBeqj9g4TCHF4cEu1/hCuro7WIkgDwlJpUUhJCZvkA+0x3pe2KMhHcB65dc1zToEqyNCiOKo+WhaIPaxAKoEtjHzojBmBmeFTJZwf/99WwOonagLuDit9T8gbq24FJpbYrQdkMVyA1mmq5gnaQVfqlZ+rpUih0dDjMJvkkjSyQg7lPF5fGSQOgtXSr1jowcc4s5l/W6/I5DZtAgkveqPuNJXf7fwux+Xoc1l4IqtpL12kdDaq+tuaIO7mbYycTrbauyNpuHy4yqIIycvEwzLX0QIJJ2S7DCufFPWbBk9OaoXGc/3d849nGISAX3VQD5cURc82Kh+uQ2SEoXOfuCRP2SUejchNPeTjJ8cYd0E9j3V8g9W5WmBpH53uDGSonazLlaBeKBzLTTcJYcHfNCSbDrfGa99XsUVK1muXu1n4qnzjule2fL6SjpqU8b1yrRZVfmHgO3AvmcGpqh/ZjY+Lyys3XPEguUvHkZaidkkqeD6jDmm9z+gi6DBggDBPnoHJ5RFeFyUenVDbC/nUW9LY21RAGeXwAnL2ogNS130j3HJ95q79tYyz0bxgiACyQUs4CbNntMY77QSkKQFGBugE19ysPa8/1clsHTem0A1jRbQ5HCIfBVYewHMe8C/BmeakhEC6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(66556008)(66476007)(66946007)(36756003)(4326008)(8676002)(5660300002)(8936002)(6862004)(41300700001)(53546011)(26005)(6506007)(83380400001)(107886003)(38100700002)(186003)(2616005)(6512007)(86362001)(6636002)(37006003)(54906003)(316002)(6486002)(478600001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xO8vHC2Im1wH0oz4MHBdvTrmQmeOcZAzndkZk81Zx8wOqQLlXpCSmqDCzaQC?=
 =?us-ascii?Q?Bq4K1Mue3H4xY+GNoxqC3QVXyr0GGv+1QAY9gH1A5TrrMdfYbl/MANULDowf?=
 =?us-ascii?Q?1CpV3aPiZrDwckK9L46N4GMz++fOG7+NYrLQ7ap7vwlSs+J/aWMyd3tu21Tm?=
 =?us-ascii?Q?Aoj1yZ0lrBkaGBu56+UyUKlapE97R1b1Wk+fGC3FrncuIsc+/J8GStCv+28W?=
 =?us-ascii?Q?Oq8IZVLotJcZlcJebY15mz/ZDrP55j93N0uw0sX8yKfyBOMboKs1Eglw1On3?=
 =?us-ascii?Q?/VeXk9XWxa0gye8pkjwVs6xsDY4mpMjBp7q4jvnk4yBUgAlnsOjsdocCUSPS?=
 =?us-ascii?Q?+A8pj7wvbY0xVgwIrcyspoJus5qlm+jZeVrAXpHSN0mJW9n0KWTBgFTcGYuk?=
 =?us-ascii?Q?t7p+nKZFG2uUTEHTrqOIUMclpv2zxCFZCe4bMWKrz+m7Q13JqUS7ptnKg4lY?=
 =?us-ascii?Q?VuD5ZW7ix6GM7bS/KeRIQPnM1NrkLRy3fpe2C2W3rHUocEnwuUagEHTU0yb7?=
 =?us-ascii?Q?r3Bpg+fiFdKarv/TDQlOdRVVIVLj+8eymzOeBYE3ti5bUqAff6W1J2ru4Ur6?=
 =?us-ascii?Q?i3jspjrNt7UXgfXOkaB5Bkse+mIRp2MQfCsIUnoBI2gX71OEG8jJdOnf9fDI?=
 =?us-ascii?Q?xk02YwQgzQa1cLdbleGP/BT99rHzUKPFliMiFvNJ1iVAvMLGtZeUAPnWdOSA?=
 =?us-ascii?Q?Y82tV1s1Zo4JSf9gJu/B8+I1Ef/2Jhhe8KlEfe9tnGkCbN32jZVcorzR7xlM?=
 =?us-ascii?Q?mHfYu7WFCWUVG5D6RXFfALb/JrG8Jsp4IvBQiWHt2HLb9yJKLSVP9EBfSwzS?=
 =?us-ascii?Q?tyNNiGRmsj94wsJVAK/ZzY3rNrgCApGS6ls4AM5HGCM7b3MnHuJwH6Zpbvn2?=
 =?us-ascii?Q?lFdt+kEBo8oY0d8MgNCyj/2LDvMACpj1IC4qkz3cMr8rhYOfYnN6E+RPdgh0?=
 =?us-ascii?Q?4UTYBd+Q74uA3HWVC4hfZ0gukV7Gyqwm60HgLBhqcWZoVpEv4+g8rzTT2W+0?=
 =?us-ascii?Q?nIIPXQMWvt28WFWVv4da457nDYMb+lhaLKiLRIJScKO/7d1KFaNY/9HYq8i7?=
 =?us-ascii?Q?3KgPFApa0Tc4dPqO0UwQXXc+0IlqiNmD0h3OUOfCGCqd7QiEKuRob8cr6OPy?=
 =?us-ascii?Q?imdennbD4aFor8yuJv/c6O5CO4TK7H4W4f5rAES8HvcqxCEHVVeUQrytj+Pg?=
 =?us-ascii?Q?01JRPSSZjWdMRkso6AipL7gdzc8h/Y+KNon59tv5yGYS2npU60lqZ6OybZo0?=
 =?us-ascii?Q?ykpJnX+YUGjjMttGSCfTtoHfal3OpXA7QLSS+qux3LCeAT1b+SEuEqPj7Sa7?=
 =?us-ascii?Q?9Uto3ketc5g+HPraa4/QSdQElDAGA4AD/XHOfB97GjxrP0Ji8i3kiPswni2o?=
 =?us-ascii?Q?RdX+qk4lavTRnYQgstH8JFU7RBJue5WK8Ejah9z74crOFLsmfDI89zCYGxAD?=
 =?us-ascii?Q?c2ZChj6fdSnMCwEgl0gP9DTxckVnB36RwS3wKWiEHxKr4cVUXN3kNmpbNK8h?=
 =?us-ascii?Q?ffNnakZ8oXXs3HgYEIzy/ql5B4YiK+Cv8uHym+QW2zXcieEXX93j1qFDR3nm?=
 =?us-ascii?Q?hgepzLzcl+B/b3vd2H3Uh65G8tNMWx0ixSriWO4H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcafe38-4280-4a3b-478e-08da9d656957
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:13:31.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnKVtFa5eZHzT80DX2y9pMVER3xG4ZsCwVad5DSqBYm0s3F3e/+di25XwpS8GGiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 23, 2022 at 09:40:22AM +0800, Mark Zhang wrote:
> On 9/22/2022 9:58 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 08, 2022 at 01:09:01PM +0300, Leon Romanovsky wrote:
> > 
> > > +static void route_set_path_rec_inbound(struct cma_work *work,
> > > +				       struct sa_path_rec *path_rec)
> > > +{
> > > +	struct rdma_route *route = &work->id->id.route;
> > > +
> > > +	if (!route->path_rec_inbound) {
> > > +		route->path_rec_inbound =
> > > +			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
> > > +		if (!route->path_rec_inbound)
> > > +			return;
> > > +	}
> > > +
> > > +	*route->path_rec_inbound = *path_rec;
> > > +}
> > 
> > We are just ignoring these memory allocation failures??
> > 
> Inside "if" statement if kzalloc fails here then we don't set
> route->path_rec_inbound or outbound;

But why don't we propogate a ENOMEM failure code?
> > > +static void ib_sa_pr_callback_multiple(struct ib_sa_path_query *query,
> > > +				       int status, int num_prs,
> > > +				       struct ib_path_rec_data *rec_data)
> > > +{
> > > +	struct sa_path_rec *rec;
> > > +	int i;
> > > +
> > > +	rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
> > > +	if (!rec) {
> > > +		query->callback(-ENOMEM, NULL, 0, query->context);
> > > +		return;
> > > +	}
> > 
> > This all seems really wild, why are we allocating memory so many times
> > on this path? Have ib_nl_process_good_resolve_rsp unpack the mad
> > instead of storing the raw format
> > 
> > It would also be good to make resp_pr_data always valid so all these
> > special paths don't need to exist.
> 
> The ib_sa_pr_callback_single() uses stack variable "rec" but
> ib_sa_pr_callback_multiple() uses malloc because there are multiple PRs.
> 
> ib_sa_path_rec_callback is also used by ib_post_send_mad(), which always
> have single PR and saved in mad->data, so always set resp_pr_data in netlink
> case is not enough.

We should always be able to point resp_pr_data to some kind of
storage, even if it is stack storage.

Jason
