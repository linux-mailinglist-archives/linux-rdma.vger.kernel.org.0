Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815575E81AF
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 20:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiIWST0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIWSTY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 14:19:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474F11A6B1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 11:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxhNU6jFt44qPXG9u6Gw8WrvuQp5Gy1VHreDKfMS9m9AqbG66fYzfMeZVOpFN0ltRY+lDJCzudcjUcwU5qsZpj5fxwaaTwmFyU0U5fbiqxlb+kX0K8xVAQZTAK+f34PD5oXyqFNCRfnXM000/Zxta73YuB9uau45Wa0QzKv/GFp2i0Q8qC1P11eiEqJeVJk/QCnjzrJ/oQTMRbXiFfwlfJaVAoFubS/PS7XiVziVjXfLIy1na3hv960q6sY2xRK4zpt60jS1tD/SCMOM60MR5wJtSLeyMhnw5fCQMTZ66SZR/moRLQYWY7nIU5logTgHveHFrxeNIuPp0Funpgbd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+06pl5+PPTJgydS8V5GsjmPRR/kg6bICGfJ8dK0FkM=;
 b=mV8SnTHB28HwUEgcpP878ijWyP+BFHgTHjJD1ruzVmLgg+XXC/J/vStw36eGoD64Z4eeeChHierjHLez84PBZGeYWFsuoOk8bh1qW2XDpUuJKPfPD0m4QCwv18h6+z0EUvHG3Fn3DtKugo4SILfGHjP3wxqlkOF6q0iJvpcASgLVjmNWmaW/FwN1isFiG9+Dcl3MiRXm+feu+EU56lXvkmfkeX5scIZeSAixCO5g9SNWo+R5XpSKyTLHiu2x3mLGo5T0JmMhqIBMSgM8fCdALzqEjZ/7xnTSM92sivmCIP+pq8oltnmfKg/6kjHi89FEFSI00LDYgTCxnxMgVkpYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+06pl5+PPTJgydS8V5GsjmPRR/kg6bICGfJ8dK0FkM=;
 b=do6h/3BhC5ZROK0dGjnDvZclF+e28V56bgXmVF2/S3l7Cie8ntacuMyGgzKHcAG4D1O594uw7TxFJW+KOrIvVPrKd8ztXdHMows90b9wwNRf1exvfQfMqH3VqWt3FDPydbrOVKkoaUoR6SPU+fe9K4Chrp+yD2GCo7VxhqewBHdMUg4Kx4qbNgku8d08o49RmoKztmgizTD8F/QibL0nPTx6lqcqNRjyyNLLeHbps7jPLYkZqI4a5MX7mZ4LXxa6nFZ3vaeb+QL1mDOrkG54IMcehouu9rVtnEXsYjzKgp/I1tysh6tBWqd3NbHIF3ff5HbO2fW/HZbfP47iJDO4Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 18:19:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 18:19:21 +0000
Date:   Fri, 23 Sep 2022 15:19:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support
 with netlink channel
Message-ID: <Yy34qAuOrLZvqHlu@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
 <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
 <Yyxp9E9pJtUids2o@nvidia.com>
 <969cf0aa-a066-5142-d917-f07130974764@nvidia.com>
 <Yy2w+kxp7ebtsdFE@nvidia.com>
 <daa5f761-9672-8598-1533-39eca4efa972@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa5f761-9672-8598-1533-39eca4efa972@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: b9080230-7aad-4c09-c798-08da9d9022ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4UOFGa+s+HjXXYWVBErlI6zKw6SKfvF8J4hd0yvKHuSDyO544wmbuCCasaKTzAuSATnom9jOuy7hDMoQte/KMW2HuLpowY/itBml4P62CY1AvENXUFYa+cMkTjC8h0XFWhhLFTSsOV9sIU+fEIQjAlCzahNaNukPFeXbp4LERbFdPbkwuYWdH33XsJeWeW4xzivB9JniBYWW55L5U4PnY3teonrWbeXWbZ3xxDhftIpE2vMM20aU7oC1h/Z/sMZwwCKIwYACmg0gUJh+D/f8hx6UmEoSKeMUoRTDAJj7K8dALm99yJj52d6n9hXRtPL3xdmEJ1zEBzqyryrlBVi6hHWjQmHzMLHRCzTLFAYmCOjvtrKq5fTQSuYdMbOlLROa0E4NE71cUWfVEfrLQWU1nkyh/ZZ+NPvDz5wXoh6hXIQi/xE+DKwPRsAspmnHT6HjCg6KQe2NqtcBfMHBKM7us3c/dR9xldhcOnTJMHvLRZqOTgg81nc1vA/9WOaBwGEehWtYfrdSAyteVVlf7l9XE+ii9lFzAdwY9QCn1lnf8XrEDjwsvJtSN+TJPGO62kBfJGvIQxpPycfZqk8QkvSRzH1yUXH9lcq0LEk2fEPjXH8RC7ZGU5rvkXDM15bKZ4UMDLMrMbmRe+imH08nTgPGTCkHhc1FwTx5vEz1mZe4Eakhh0k6i+q02pnQG4CWNFdBWaxEGvqTOJWiD6ePhtrLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(186003)(2616005)(86362001)(26005)(6506007)(41300700001)(6512007)(5660300002)(4326008)(38100700002)(36756003)(83380400001)(53546011)(107886003)(2906002)(37006003)(66476007)(316002)(6636002)(6862004)(8936002)(8676002)(54906003)(6486002)(478600001)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enQmdEXdgDTWGZJc18tb5SQTlrGUu+AG3Zg6pNj+5wcm216hDL/xki/BauS3?=
 =?us-ascii?Q?5Ne3kNRAWmhxQ0sAobMuMAnL1cZI1O4OiDeSJxoorDCCrb0ndAydh7HaJPAJ?=
 =?us-ascii?Q?UsUw0q4K4OINoB3BtRmDB8hRstIx2MzSuEwj142awmlgtpPevPcV4DWXf0wL?=
 =?us-ascii?Q?1TUOUgJgJZBbkQmoLz9tgF18db9KN5jEnCVhg4jcsQqQXCCuiLL8EeXxrFBe?=
 =?us-ascii?Q?tulaXHLlWaqf5TbDVgjcpsyYdZ0EGn94nY9B3iiNrEFllAtWYnkqwCeeLlkk?=
 =?us-ascii?Q?250VW80D7VhyKnWutj45tTT7ikiSR6qY/5pQL2K/ceKBe6bDth3sIXdOCxp2?=
 =?us-ascii?Q?aA5tpFag4ooKG1M5kZSkLP9lCHmX/hNtywGczJazAfJRPcQv/ywLTYnqPl1U?=
 =?us-ascii?Q?tsGK+H80+FcE+iMYVEdPH6aBuvYyMllj0K3mT46XHomYRmEPcD9qc0DN65bv?=
 =?us-ascii?Q?jkT6gZyXHljZ1iHwP7reikVIxLfpzYDx3ePznIyXrBwGRfI0bRZwEn5HhhAo?=
 =?us-ascii?Q?hV0CrAn+NZgssgQ91vS/RLULl+5JbrMzuQyg4ll/yXFERDa+TWOybhteoqzV?=
 =?us-ascii?Q?5veTRCzTSERkMdU/FOOcDIC6MFS2LEWV8QIEMwNpj3exKsvEv+NV+qyWF//k?=
 =?us-ascii?Q?IG3kw+5qj1qlR7JcKIX9Y+yAg2N/i8xURHKaoDGdr5S5GLY3dWBjmbmQfV2f?=
 =?us-ascii?Q?0Q148hfmbOvxe8vUtQbuzZPH4pUJ6Y3X9JKHG7OawVORnmlkv2Kl028aZahE?=
 =?us-ascii?Q?IVQBkXitt7SJSCv87PuK71E+zrY5hXnh/uXqVg0IE5mp8KqD51TWlDuBld57?=
 =?us-ascii?Q?9d0tov3TVdzLMxmiUVXPbErCTyJhK//6YAa6DtjEhrllSQ496/uvZPuTzF9p?=
 =?us-ascii?Q?4wbvcrJyiMrSNLVkFMCTWM4ZnuBttY+xT9GoJvx8PvpSefKXUjQwnlnSqNhL?=
 =?us-ascii?Q?Kf7NsDHwraXR3SKtxKrNliihXiXgKm9xBw9182oaQQcqx9m2CL3/BgM+MSPR?=
 =?us-ascii?Q?j511H4DjAgFPLUUE35E7dqb7bNglcFi2tm196FvV+ZXRaWmSbl2MNFyx+Hgt?=
 =?us-ascii?Q?Tjdlg85VLOP1OnDIRBUrvTq2odavOp9D2mO8q/6WhqtzqVlhqnb/xzJwK+RU?=
 =?us-ascii?Q?fTWo88nRSmO9GqOXNXiRsGWEpanvzUwyzowKDFmI/SI4Egy2yT9C8gMvZkiS?=
 =?us-ascii?Q?z6yQwRO56aMvysgyK3jU/sZvPAypA+oVbL1ccnOAoqwaVi5RgFIcqxjReNjm?=
 =?us-ascii?Q?7FoZ+n5kF00NRKkKBpKsPTnBZLqjd6trVzo+9hM2zXMgVS6BgId1He6Xx2e+?=
 =?us-ascii?Q?7UIedKBor/Oz8UJ4u3SAg1HHdkh3yb7TrjG53i2bB8V3yct+MpTHC9fU2aqV?=
 =?us-ascii?Q?PfY3Y4JmeAE8qh64Isra/GeejmDP6MJo8ZYKEixHp+9MytadO8ILE/9B+yvT?=
 =?us-ascii?Q?ILH9YB3+XFZGCdOIQO5i9slMw1R48/Mi2M4xilwh9hff8fighSCp64eid5J7?=
 =?us-ascii?Q?DLIuOaxBYEYAtgIfdlv8PJvC54uTbu38u6x2radHSy+WH1kPu2Ua6knX/8Ao?=
 =?us-ascii?Q?ccccB+wkBqnXznjQI6fgX0EKes/vC2VHgX9mlYa+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9080230-7aad-4c09-c798-08da9d9022ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 18:19:21.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxXf1HFGupBQXKrYpav/M38rNXNos/4pIRQfJ38FPVHvCJ8Cgp02q6ba3/2uI/N8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 23, 2022 at 10:24:35PM +0800, Mark Zhang wrote:
> On 9/23/2022 9:13 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 09:40:22AM +0800, Mark Zhang wrote:
> > > On 9/22/2022 9:58 PM, Jason Gunthorpe wrote:
> > > > On Thu, Sep 08, 2022 at 01:09:01PM +0300, Leon Romanovsky wrote:
> > > > 
> > > > > +static void route_set_path_rec_inbound(struct cma_work *work,
> > > > > +				       struct sa_path_rec *path_rec)
> > > > > +{
> > > > > +	struct rdma_route *route = &work->id->id.route;
> > > > > +
> > > > > +	if (!route->path_rec_inbound) {
> > > > > +		route->path_rec_inbound =
> > > > > +			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
> > > > > +		if (!route->path_rec_inbound)
> > > > > +			return;
> > > > > +	}
> > > > > +
> > > > > +	*route->path_rec_inbound = *path_rec;
> > > > > +}
> > > > 
> > > > We are just ignoring these memory allocation failures??
> > > > 
> > > Inside "if" statement if kzalloc fails here then we don't set
> > > route->path_rec_inbound or outbound;
> > 
> > But why don't we propogate a ENOMEM failure code?
> 
> Because inbound/outbound PRs are optional, so even they are provided they
> can still be ignored if cma is not able to set them (e.g. memory allocation
> failure in this case).

This isn't how we do things, the netlink operation had a failure, the
failure should propogate. If we've run out of memory the CM connection
is going to blow up anyhow very quickly.

> > We should always be able to point resp_pr_data to some kind of
> > storage, even if it is stack storage.
> 
> The idea is:
> - Single PR: PR in mad->data; Used by both netlink and
>   ib_post_send_mad();
> - Multiple PRs: PRs in resp_pr_data, with "ib_path_rec_data" structure
>   format; Currently used by netlink only.
> 
> So if we want to always use resp_pr_data then in single-PR case we need to
> copy mad->data to resp_pr_data in both netlink and ib_post_send_mad(), and
> turn it into "ib_path_rec_data" structure format. This adds complexity for
> single-PR, which should be most of situations?

You don't copy it, you unpack it. We already have to unpack it, just
to a (large!) stack var - unpack it to resp_pr_data instead.

Jason
