Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFCA72AFE7
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 03:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFKBIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 21:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKBIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 21:08:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4135A2
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 18:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RazkSwDFHwTkzvwbPepkeumvN4LwcZrbpGVRKIYHEdIHO6/xBtpt2dACeoG8VmHiT0HB/PyLxe5fHHo3mNk9HwwfifZAutowH1ujNmbCA7Bx/ilExPq3QVb65eITMuoxuy/bs4KmNoJXmwu8GaKzzkZFgPvwA7Ewt7SXD/nsOhkRMs+XPCCINLl0Yln3mRpCT1wK053vmCQ9uPwuh1qXYpgovtGvkRFw3CkH7QrkSlkT5sKWW527fsfcOuP+cim3EQ4Wa0fmUXImcBzJAA0eQ7pqNv4f4dX4wDvzJgrKuDsIdNTQnVIOfrH2WdN5iesCOsLBPIukgXugSAbUvJydaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yNEChJzX1Nsxzve1V0Ibu2wS1ocMJZnWVe9XneEE6c=;
 b=Vzy+ct05f1N5Hg9VhsJ7CUcAGQ2cOoxQilBBg0R8FNzjz9lwoTX7pL/W6pesqYOvk1OTB6Ecd7e2u1F5+FHRyhboEDmoqiMEXNcjaO6c9oLTuPBqelmcy9E7Eil10NKNmXEUBSP+YVAgc6FavYd8KCU7F1YE2obUM5u4WZCwanvjXKVxzx8U0SrD4ASqx0/Ati7ECWDHGc0/sOhmXdqqwR6MY21PoLjPTfk69JMEX3yV1ye8xZwlScSMivzR/RmvU2y52u/tjC36BA7Dc8UW8eCRkpgUzEjRsBMVMDaoe+5xhPfemT0P3WADDl1osNVngPnUXqHMihf0B2gGyDbhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yNEChJzX1Nsxzve1V0Ibu2wS1ocMJZnWVe9XneEE6c=;
 b=Ps2e9scvpTkijyq8AQq3cwzdK9GH2jRlnndABimPCjSKG5YYn8gEEVweFucjr8cy3m1UlvxafhK94fMAvajw0nJdFx2lKQdtrj2B9t3gzyWRA0DF2mrRz6LhYmAVGI3HADQacfzve7FIJwupIpP17A31RdwcDbVpgGp2c4JrqrpuYuQTzbpCpyyKW+DKUjoiAAzxK2B9k2FdFM210z6EVjDaAQsJQzQwRky06Ggt4Cg3YVezBIpweRlHeAYA92uirW4ocEuwNlLGsiR8suT9vmKYyQm0xZFWV6kaM3F3wJYs8j8aAu/WQvvwadTvWpCDGpt5RBQ5PCEek7Ds6iSv/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Sun, 11 Jun
 2023 01:08:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Sun, 11 Jun 2023
 01:08:33 +0000
Date:   Sat, 10 Jun 2023 22:08:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Chuck Lever <cel@kernel.org>, BMT@zurich.ibm.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Message-ID: <ZIUej/a5GgyU808G@nvidia.com>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <ZIRm9s9xjq3ioKtQ@nvidia.com>
 <b7e3081d-51b2-b74e-5e22-cfcab88dcc51@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e3081d-51b2-b74e-5e22-cfcab88dcc51@talpey.com>
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 2348586b-43ca-4cf1-5b6a-08db6a186039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tse0oKuZeHfd/0VIE2DkHEA5+QmCgSGANcy49fC/gVXNcmNzr9CoYIlNFIEpCSLfMrgxBhNCQKXbWS7Srud7S/nHljACRwDI91JPOVepvXb7L96jHiCXRGZOuf7w8xd3U5V7b54EWsSUCwTZ1I/uVQe5MkadbDDZnvEhNNp2lpWdjUXIglAzh4vTT1Xk+rnmN9zPs7iHs6ILyC+jZmdZa7mRCfiIZiNLLl1vDStW7Va1LRmIT8XnAEyyULUPhEEt7n2aCUe/5GWwL2fA+PFMrcyoc8DSqwA21pz+GI1mdS9NyQdj+VIVzfDk7YjsiCQDIEUo8oS36wR535PkAwyg+iUxEChodIcLXOMj5h5JCRTAekxlcm8AHcrtqxyowxecq84qUAd9XkSggr3SYWMDQVXK2GEsZDKff8B3CSKrtCsYHSAUJDp/vpeuYR76dUPHtwFu46JM81OMB5sDPNj77i/RQuvyMvIa+BSzcmrgeFQ9axB719JMg9hQzKW7vlMmn2G/vXh09LXjS8Okl9gBGm1pBjmx9p207eU3cnrZKg8EoGw3IgXfTVoeiOkI7v6Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(26005)(6506007)(53546011)(186003)(2616005)(66899021)(6512007)(83380400001)(6486002)(2906002)(8936002)(8676002)(36756003)(54906003)(478600001)(6916009)(38100700002)(5660300002)(86362001)(41300700001)(66476007)(66946007)(4326008)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcY3MBguEpC27Yu5Vnr9nYUFlgkXt6vQTxgjSrJKt1Ac2vKs3nPdTbOFn/V5?=
 =?us-ascii?Q?PruQODLuwf077Mk0++3NmuvqHYbEKdk3TlvLCOiFGwOdB8MocmomOzvHER/6?=
 =?us-ascii?Q?Be83Kwt5Mq1lNxR33BvEPIbpmj3zVO36ASJZ/eC6P66frao4vHAxmNss7r3t?=
 =?us-ascii?Q?y2Nli8ooVuJX6BB85oH3rB+exrOXFiuv77zDzfdsTIuQ2zD88OqRZu7KKjA3?=
 =?us-ascii?Q?afGfUc4KgPE76mV2lhAKx69FObij/S7n1YUAl06XWrxjrxysQqpq9VyTGTeW?=
 =?us-ascii?Q?0ahegDCTdBQwe5m7ZDNM9hRFjRnpH8YXSlKi1aS0uwwcnMyh8NrUNOaKTREu?=
 =?us-ascii?Q?qpe309NXrlPSMdVz3kT1RF0s3ASNXFUkP7CKP9liXZL5IBjmQjHxPCBOPi4v?=
 =?us-ascii?Q?SDX96K6ZHbNZMLJT8vvKiSYSU6l86N0cIERwDimWB/iGFzfYJ/oHQTWThMyg?=
 =?us-ascii?Q?qGgrXbea1i9PdEhJ6SCAEMm9Tz5ycFikP7+o0aKgABzKtKSkCQlcYR9LiBxa?=
 =?us-ascii?Q?35C4nk1d+JMtU9NR0ul6gS/ufbR6bPR8S+PwA76WurH6TRlvA7O24Kkw4O+U?=
 =?us-ascii?Q?TOnv6fsLDH1kR3/9yh5gcLnRpnrBl5s/6uji6jVF4xLcsRsGdmGyFFc8P/a8?=
 =?us-ascii?Q?cFHNhMyNM9zuJ8DyUxbPveAsLp0f0YsBwaZOg0RU/FW2niG+iuktwJIIpMnQ?=
 =?us-ascii?Q?rySSjSqvZk6ArBQdMpJzUoyfPZIWl6SRpkWVTFRZw0RjqJ0tajkc2/Zdg037?=
 =?us-ascii?Q?8vLyplImqjRXX5WwhUzZbXzJ/YOryML11ORlHSeO+7ueoeD1V6vK7/otPTyb?=
 =?us-ascii?Q?cEfxZ93fjwJ0EDn1dSALyhNoSzge8lJxV5T4omr8HFgnvWItb/4ZyluDHMvx?=
 =?us-ascii?Q?txQ8itcbMvNm6dFfyFjHYKjqDgaeAc1IClSXYZjnt9HEFlBD4Hf4ZE9Ve9CX?=
 =?us-ascii?Q?9UCRnZAmkIFkcNepBqJcpmKj+iYdv/Of2BsQ8Nn3WPhHzfY2egvCsJLEdrWw?=
 =?us-ascii?Q?XiCb/6zpYwA8lu6GzWJdvyU2z7FfRpepkryDcMOzVcSR3+LFl4quKSk54BGd?=
 =?us-ascii?Q?yaZmd+cxufIpW3HXIOlBW03NQPASR5edUv1lXJAkDQs2pe/q6zg3sNp5M8/U?=
 =?us-ascii?Q?q+UCqpB3nTTHcvoPni17nPV/OlYWU0soLC0k+ZNy5ngav1i8m9NV3nOVtnRM?=
 =?us-ascii?Q?kDlDHBw/lqnukGjjZkq8HN15IZMgZiRzzjPOW/KuMMtmDPnGfqjCKlZWSNDO?=
 =?us-ascii?Q?k0ujMNoXYt8eOqDbyNPYdfXWftXCO+/cB9j8rEnqT7AT/ybSHmNimGxrFE9+?=
 =?us-ascii?Q?nwCYxOMYdQ6B6tPpQUCL2Bu50s0DlFT2y6jBoDl5xXq9GpSt/jndS9G/siGe?=
 =?us-ascii?Q?OkASV/Czg4D9vdv2EM63hb0Dt1OXmYLiL9WBVzPdyy77BOid6kNU6rFaxMDD?=
 =?us-ascii?Q?MoEySfx2NaBmQ/nEOeqEYgOTXMXuWJaRJAXnMtoWLw6IRrdcDZ8CuNUmA1UE?=
 =?us-ascii?Q?yWs2i/iuq51ghKKWvL31LsVdfrOc2wpEE3uAdUuJ83pjCQb1eFQo2LZ+bPRW?=
 =?us-ascii?Q?HjqXG0GZcCZ2grT0hVY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2348586b-43ca-4cf1-5b6a-08db6a186039
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 01:08:33.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQUc4Vfj73h/HBQtGsA47Ay8mTzW01sQwacY3LMdrk4nxGKErA8oWl3LmPAKPylZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 10, 2023 at 12:38:53PM -0400, Tom Talpey wrote:
> On 6/10/2023 8:05 AM, Jason Gunthorpe wrote:
> > On Fri, Jun 09, 2023 at 04:49:49PM -0400, Tom Talpey wrote:
> > > On 6/7/2023 3:43 PM, Chuck Lever wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > We would like to enable the use of siw on top of a VPN that is
> > > > constructed and managed via a tun device. That hasn't worked up
> > > > until now because ARPHRD_NONE devices (such as tun devices) have
> > > > no GID for the RDMA/core to look up.
> > > > 
> > > > But it turns out that the egress device has already been picked for
> > > > us. addr_handler() just has to do the right thing with it.
> > > > 
> > > > Tested with siw and qedr, both initiator and target.
> > > > 
> > > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >    drivers/infiniband/core/cma.c |    3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > This of course needs broader testing, but it seems to work, and it's
> > > > a little nicer than "if (dev_type == ARPHRD_NONE)".
> > > > 
> > > > One thing I discovered is that the NFS/RDMA server implementation
> > > > does not deal at all with more than one RDMA device on the system.
> > > > I will address that with an ib_client; SunRPC patches forthcoming.
> > > > 
> > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > index 56e568fcd32b..c9a2bdb49e3c 100644
> > > > --- a/drivers/infiniband/core/cma.c
> > > > +++ b/drivers/infiniband/core/cma.c
> > > > @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
> > > >    	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
> > > >    		return ERR_PTR(-ENODEV);
> > > > +	if (rdma_protocol_iwarp(device, port))
> > > > +		return rdma_get_gid_attr(device, port, 0);
> > > 
> > > This might work, but I'm skeptical of the conditional. There's nothing
> > > special about iWARP that says a GID should come from the outgoing device
> > > mac. And, other protocols without IB GID addressing won't benefit.
> > 
> > The GID represents the source address, so it better come from the
> > outgoing device or something is really wrong.
> > 
> > iWARP gets a conditional because iwarp always has a single GID, other
> > devices do not work that way.
> 
> Not sure I follow. TCP is routable so it can use multiple egress ports.
> That same routing means an incoming packet bearing an appropriate local
> address will be accepted on any port.

sgid is about the outgoing device (and usually IP, but not for iwarp),
and RDMA is always bound to a single outgoing netdevice

> So still, I don't think this an iWARP property per se. It's coming from
> the transport and its addressing. I'd hope that this can be gleaned from
> something other than "it's iWARP, cma needs to do ...".

Well, we are supposed to match the sgid based  on the outgoing route
selected, but the iwarp drivers don't setup their sgid's properly..

You are right it should be fixed better, but I'm not sure anyone is
left familiar enough with all the iwarp drivers to do the change.

Jason
