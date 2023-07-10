Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4205274DBE7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGJRHC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjGJRHA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 13:07:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE12128
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 10:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPw22VtmjRgk6N3nAxtvw71hmxehGMTMJ01ci3QlhRH1BNOpa401oUckztf37gkjrh75TW/KMjCPmN5QDo1rX6PGQcNFo6BCwHJWdtWz5HYNnJUa0U6atGkTgmzODqQ4IDrY1wcN7fGwl4HnZwumvVx80LAjt2VnriMhvlQzQC5Y0bkxgIEnd9OCOC+S5H9QEj1Q/GFPwIO5RmHAzeYyFnaYq44xSVOEvz3aaTKnzjH3kkgAKEp9YCtwPSF059Y2P600WGkLfv4YpV5O6LRxicq5j2gu9RkyQgkbNA82bFvnJ6n1xHr4NOczsvmN6ntGm104V++ROIP5iUgYVsS6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsQ8hq5rRklUrAEPKp2WYg+oiszuA2oxG59euJrugrU=;
 b=QOdZA/arMbtnDW9jR8FTctvppLmHpiF58UXUofD7ln5M2xzg/2KOwnc5xe2BgVt9x6/AiPtjx9EYBtGT8x62oqs8VB2AeGKeCRVoWb6ldklRt7BGDrplJ/5jgcXpn14tqapy/0FQS1fMKJrCxsTiqQWBbTTfuzBJFbOHEMoxNFjzcRv1po3a4mQc69UwHcQ3bqueu74OnpjCgtEygc3ZlCGwg2WzQKYbbbpF/80YIyfTe0pL2Rrs6Trnlus3jT7yWT4eruUHGmQPRH7TrKJ1I6mrO7RYgmRuRNc2ALhpqu5BKo0DDyMvTUp5mbQidmdZwYYk2JUUa3e3N0lZ2uReJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsQ8hq5rRklUrAEPKp2WYg+oiszuA2oxG59euJrugrU=;
 b=CrXRxSwquRHeu/jNYF+jeEtnPt7xbfBrav47PXMKQ4lluHCp9WMsHwG2k/lY4WzdWlCFlC70/4CpvmZJaWxERyCCZ9M/foqy61wh1efNvd2E5vK7iXrh77Lfq33bdRLs/6OIsdHyXxHffOWTfz05tD5T2nCNCkAgHlgy/CHsm53SmK6ofbvKxaW/05/WgphCQpqEWEeThZiLRNcyk1V/OXDDdlTlyE+ZK+CYdLRCanLLoTwcGFPWBLlXQJK033norJ1uLVJQ56Mmb1LCo4dPs0vafn/4fJssUA7EksvE4qX4V1ugMaiZYhOEOIFGPJ7IYBYpLOiiPyKt8UXPrBjGaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 17:06:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 17:06:56 +0000
Date:   Mon, 10 Jul 2023 14:06:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Message-ID: <ZKw6rySZlRLCls+L@nvidia.com>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
 <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
 <ZKM4jM6Ve5PUhHFk@nvidia.com>
 <a8f54410-f680-190a-5e00-3226f186b2d6@talpey.com>
 <50C32C40-D3D8-40CF-B332-C12FEE894FDF@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50C32C40-D3D8-40CF-B332-C12FEE894FDF@oracle.com>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: a105c943-2b16-4172-fa5f-08db816810cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oqEiTlruVtJvRM8sbZAsDni5dQc+op2Kh+q6X5V2Cp1vWiqu3Xyj4YxoxzYMORFEaVB4biIa8y1pODOvRdf1h+C+xTjgGPZzw4KV0NyhXnGgk6sACpPoqLrEdFV7BuehnakZOaExhNP3qHgqDEa4/KnTqGGLf8wP/VN9H7AKMp7dKCg662B/gdmdZyyhr1LMGV5VdmvIfkvEqXmPHJwHiSd/6aF6BwpfLrmL4I1heJjCz36Zdfz2MtZs6x1ZEtlcbNPUUWGNPaXUaN46H1Fs/HWzqqA4ZW0epZGw6vIUpGFdh5I3syd4f1NIPXtNCGTWEOch2fcPMbhj97J/nJy7isunmTqhURRiFkJ7f4tAjryxpJEqpJiZ+W6wIzTP+f5hFlShUi4dTEzX1y/xK3keO0PbJSL4VJoyUJTxpFBVHV3GTDAXtTTmWGGteMIRQzIScNqDoOlD+ztMddeCOY8BFoKylYttbwk092NspZxfIP4yCidNsu4KRYEI4Iqx+LgoV2Gk+Pw7+BaFZxVjDzDkBfD94zmsCDaXY1b96StgqDbIHjBuvrwQAzxVZwDOKImGX4LKbrE6vyoRHWlM02v2Y9NL5khvQ5Lk6K/hh2TkLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(86362001)(38100700002)(36756003)(6486002)(54906003)(53546011)(26005)(186003)(6506007)(6512007)(2616005)(5660300002)(316002)(2906002)(66556008)(6916009)(478600001)(66946007)(8936002)(8676002)(83380400001)(4326008)(66476007)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PiLjyd/AY+iE+iEsaiYbgM92wyReXhtOxDnafwgyv2oQiSbV+YRToSAH4wQG?=
 =?us-ascii?Q?dJI3eJ9zEqbWbcLXmww5cmctJazt0MzQKZzEC8rog1ccTQnIvZ1vvVRpWrO6?=
 =?us-ascii?Q?lCslEa4bjHOLE+SAnIzyPUwmjl1UeLSb9h0339etQc/f6YMxToHyR+3eNXVN?=
 =?us-ascii?Q?9WOXVJX2kx8YI0Hu6PvLDCXEZfqznT5QqT6hPcrUT3/MkV3Q+iLhvYZ12pO6?=
 =?us-ascii?Q?NTe0Cn2i4EBEi83vfP349kyE1HyMTy1AZYVDfpiCkwTHxcB5egRgTGByjEBf?=
 =?us-ascii?Q?qyfySaJgCDwOD2XMXRdcghrTUf98NDaU+WDZYGP08p94xhmHiIW5+9O/vkqC?=
 =?us-ascii?Q?PqQxA8EG4SAkuORn8uayZZJeVN7TQejax+D443eOELbXYEDGh/44M+VeqkfN?=
 =?us-ascii?Q?Nated22OJ5BPzOMAdarKUTxHSrgtNrlBVpWGncFynO+wq6h/km/+ooCsZKNu?=
 =?us-ascii?Q?FhcYpBvf2vJt6wHlca/WTJxHpM8KD4KFk/zvablHfNi7/fhp4f0WxbgAt13l?=
 =?us-ascii?Q?/hlMcsYBpaWKEM9/IpkY2M2r4nLVOOAv0Boey4BU2J+Sa6ZQAZF93/dubROn?=
 =?us-ascii?Q?NRxWdaHkzs18ItS8rIPylj3tRyBe931QKMwq16/Cl9yzPG4NITckDZMoNrj+?=
 =?us-ascii?Q?5IjEQU2sKws1ZsMNg/h7zVfWnippCVrJs/y4t/37Ksl3uRTf/t6E/T5cEdsy?=
 =?us-ascii?Q?7PfEsYWhS4SDPMiyBCP9j+FGncIoxxmNZd7Mh9edIyZtRuuTlyp9lzpZxY1H?=
 =?us-ascii?Q?7wN3dAWfniJ53e9POGIQuKGhjGje3Cq7aHCmK4PSfp6j4mdJdC5wgn/hZNjg?=
 =?us-ascii?Q?JnuJkyr+JzaDt6KnUfwOmLsm5c7ZGJ79MGPEwQwkjKtNZQJgjNQAxIyBquPI?=
 =?us-ascii?Q?Nl7ZKpPQDx5rr0KAGjJSymigehzhvRRMRW6M+CaF/xk7EG+lY8OYGalJ56fj?=
 =?us-ascii?Q?tZghVzdN5BRde4JdXv2PqRPCXUmEpg4a6CfZ+nygLqYwVzR2F34P/PT59Ea0?=
 =?us-ascii?Q?jqpgTzPZXmsWm1phzu4WsqhB/Xyb5253USNovoJtF/j/oJ1MxTFzh/6PBhgC?=
 =?us-ascii?Q?w4vWkL6OG0WIZD5jeZYqOqEQPawXSGd0jTCQTsLEW7llwIpNVWITrBQrw8I3?=
 =?us-ascii?Q?oVBcoacyk1CIR+rQrKewi04GaeFCubcZ5MCmKibFt/58kSKhfeJ3zcJB5hKT?=
 =?us-ascii?Q?YXIck/8939xVv6P+UjoLcPJxeiv3VY2MHcWqC1se8Qx7dInM6CxHSAXZ9m7d?=
 =?us-ascii?Q?xJJL1LWVqBVYVobaaw0tbL0b5EHC6uLPw59VXhFiGzJWgKoqTazpSj41wlxz?=
 =?us-ascii?Q?uNy1jYo1iHc3Axrr4Vf5tf6/MK36OA1t1kF++iNwepWuNQzepnSf0+sfV0ub?=
 =?us-ascii?Q?9Ez6TzmIx4g6LdX6HBlJuusEt8hYOs33L9mTxGij/EM3L3ixO/89m2JMce8Y?=
 =?us-ascii?Q?urYY1j2uRyeTGIk2fXsgFKlrf1AjT3B34FYC0BdVEV/geqxsy5SPc5Z8I8F9?=
 =?us-ascii?Q?F2uMyk6NHgf82+ktP9uSvaiFmmKjEJVLmEPsPJonVyDQkBI3vqnlF1io/nGo?=
 =?us-ascii?Q?XhPObWb2MKVj4jbkDGGZXolczgktvgmX9yJFVmos?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a105c943-2b16-4172-fa5f-08db816810cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 17:06:56.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IItrT5V40+Lvumkukj8y8r15b0oMY6AT3F0r0Sf+DyLHS+EXySpe2+VyKalEpegs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 02:54:59PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 4, 2023, at 10:23 AM, Tom Talpey <tom@talpey.com> wrote:
> > 
> > On 7/3/2023 5:07 PM, Jason Gunthorpe wrote:
> >> On Sat, Jul 01, 2023 at 04:27:23PM +0000, Chuck Lever III wrote:
> >>> 
> >>> 
> >>>> On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
> >>>> 
> >>>> On 6/29/2023 11:16 AM, Chuck Lever wrote:
> >>>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>> We would like to enable the use of siw on top of a VPN that is
> >>>>> constructed and managed via a tun device. That hasn't worked up
> >>>>> until now because ARPHRD_NONE devices (such as tun devices) have
> >>>>> no GID for the RDMA/core to look up.
> >>>>> But it turns out that the egress device has already been picked for
> >>>>> us -- no GID is necessary. addr_handler() just has to do the right
> >>>>> thing with it.
> >>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> >>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>> ---
> >>>>>  drivers/infiniband/core/cma.c |   15 +++++++++++++++
> >>>>>  1 file changed, 15 insertions(+)
> >>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> >>>>> index 889b3e4ea980..07bb5ac4019d 100644
> >>>>> --- a/drivers/infiniband/core/cma.c
> >>>>> +++ b/drivers/infiniband/core/cma.c
> >>>>> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 port,
> >>>>>   if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
> >>>>>   goto out;
> >>>>>  + /* Linux iWARP devices have but one port */
> >>>> 
> >>>> I don't believe this comment is correct, or necessary. In-tree drivers
> >>>> exist for several multi-port iWARP devices, and the port bnumber passed
> >>>> to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?
> >>> 
> >>> Then I must have misunderstood what Jason said about the reason
> >>> for the rdma_protocol_iwarp() check. He said that we are able to
> >>> do this kind of GID lookup because iWARP devices have only a
> >>> single port.
> >>> 
> >>> Jason?
> >> I don't know alot about iwarp - tom does iwarp really have multiported
> >> *struct ib_device* models? This is different from multiport hw.
> > 
> > I don't see how the iWARP protocol impacts this, but I believe the
> > cxgb4 provider implements multiport. It sets the ibdev.phys_port_cnt
> > anyway. Perhaps this is incorrect.
> > 
> >> If it is multiport how do the gid tables work across the ports?
> > 
> > Again, not sure how to respond. iWARP doesn't express the gid as a
> > protocol element. And the iw_cm really doesn't either, although it
> > does implement a gid-type API I guess. That's local behavior though,
> > not something that goes on the wire directly.
> > 
> > Maybe I should ask... what does the "Linux iWARP devices have but one
> > port" actually mean in the comment? Would the code below it not work
> > if that were not the case? All I'm saying is that the comment seems
> > to be unnecessary, and confusing.
> 
> It replaces a code comment you complained about in an earlier review
> regarding the use of "if (rdma_protocol_iwarp())". As far as I
> understand, /in Linux/ each iWARP endpoint gets its own ib_device
> and that device has exactly one port.
>
> So for example, a physical device that has two ports would appear
> as two ib_devices each with a single port. Is that not how it
> works? It's certainly possible I've misunderstood something.

That is how I would expect it to work. Multi-port ib_device is really
only something that exists to support IB's APM, and iWarp doesn't have
that.

Otherwise verbs says a QP is bound to a single IB device's port and a
single GID of that port. It should not float around between multiple
ports.

So, I don't know what the iwarp drivers did here.

As for rthe comment, I don't think it is quite right, this code
already knows what ib_device port it is supposed to be using somehow,
so it doesn't matter.

I think it should be more like:

 In iWarp mode we need to have a sgid entry to be able to locate the
 netdevice. iWarp drivers are not allowed to associate more than one
 net device with their gid tables, so returning the first entry is
 sufficient. iWarp will ignore the GID entries actual GID, and the
 passed in GID may not even be present in the GID table for tunnels
 and other non-ethernet netdevices.

Jason
