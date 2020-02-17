Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D38161513
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2020 15:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgBQOu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Feb 2020 09:50:57 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:10586 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgBQOu4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Feb 2020 09:50:56 -0500
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01HEokQh022638;
        Mon, 17 Feb 2020 06:50:47 -0800
Date:   Mon, 17 Feb 2020 20:20:45 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATH for-next] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200217145044.GA1024@chelsio.com>
References: <20200217141146.GA1908@kheib-workstation>
 <20200216134249.GA7456@kheib-workstation>
 <20200213130701.11589-1-kamalheib1@gmail.com>
 <OF9565E197.68A7B59D-ON0025850D.0049D122-0025850D.004CDC1C@notes.na.collabserv.com>
 <OF10DED8FF.9794F86F-ON00258511.003822AA-00258511.003827A8@notes.na.collabserv.com>
 <OF2F71177A.B62840BF-ON00258511.004F75BA-00258511.004F75C2@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2F71177A.B62840BF-ON00258511.004F75BA-00258511.004F75C2@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, February 02/17/20, 2020 at 19:57:54 +0530, Bernard Metzler wrote:
> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Kamal Heib" <kamalheib1@gmail.com>
> >Date: 02/17/2020 03:12PM
> >Cc: linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
> >"Doug Ledford" <dledford@redhat.com>
> >Subject: [EXTERNAL] Re: [PATH for-next] RDMA/siw: Fix setting
> >active_{speed, width} attributes
> >
> >On Mon, Feb 17, 2020 at 10:13:21AM +0000, Bernard Metzler wrote:
> >> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
> >> 
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Kamal Heib" <kamalheib1@gmail.com>
> >> >Date: 02/16/2020 02:43PM
> >> >Cc: linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
> >> >"Doug Ledford" <dledford@redhat.com>
> >> >Subject: [EXTERNAL] Re: [PATH for-next] RDMA/siw: Fix setting
> >> >active_{speed, width} attributes
> >> >
> >> >On Thu, Feb 13, 2020 at 01:59:30PM +0000, Bernard Metzler wrote:
> >> >> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
> >> >> 
> >> >> >To: linux-rdma@vger.kernel.org
> >> >> >From: "Kamal Heib" <kamalheib1@gmail.com>
> >> >> >Date: 02/13/2020 02:07PM
> >> >> >Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
> >> >> ><dledford@redhat.com>, "Bernard Metzler" <bmt@zurich.ibm.com>,
> >> >"Kamal
> >> >> >Heib" <kamalheib1@gmail.com>
> >> >> >Subject: [EXTERNAL] [PATH for-next] RDMA/siw: Fix setting
> >> >> >active_{speed, width} attributes
> >> >> >
> >> >> >Make sure to set the active_{speed, width} attributes to avoid
> >> >> >reporting
> >> >> >the same values regardless of the underlying device.
> >> >> >
> >> >> >Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> >> >> >Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >> >> >---
> >> >> > drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> >> >> > 1 file changed, 4 insertions(+), 3 deletions(-)
> >> >> >
> >> >> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >> >> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >> >> >index 73485d0da907..b1aaec912edb 100644
> >> >> >--- a/drivers/infiniband/sw/siw/siw_verbs.c
> >> >> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >> >> >@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device
> >> >*base_dev,
> >> >> >u8 port,
> >> >> > 		   struct ib_port_attr *attr)
> >> >> > {
> >> >> > 	struct siw_device *sdev = to_siw_dev(base_dev);
> >> >> >+	int rc;
> >> >> > 
> >> >> > 	memset(attr, 0, sizeof(*attr));
> >> >> > 
> >> >> >-	attr->active_speed = 2;
> >> >> >-	attr->active_width = 2;
> >> >> >+	rc = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> >> >> >+			 &attr->active_width);
> >> >> > 	attr->gid_tbl_len = 1;
> >> >> > 	attr->max_msg_sz = -1;
> >> >> > 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> >> >> >@@ -192,7 +193,7 @@ int siw_query_port(struct ib_device
> >*base_dev,
> >> >u8
> >> >> >port,
> >> >> > 	 * attr->subnet_timeout = 0;
> >> >> > 	 * attr->init_type_repy = 0;
> >> >> > 	 */
> >> >> >-	return 0;
> >> >> >+	return rc;
> >> >> > }
> >> >> > 
> >> >> > int siw_get_port_immutable(struct ib_device *base_dev, u8
> >port,
> >> >> >-- 
> >> >> >2.21.1
> >> >> >
> >> >> >
> >> >> Hi Kamal, 
> >> >
> >> >Hi Bernard,
> >> >
> >> >> Many thanks for looking after this! So there definitely seem to 
> >> >> be applications which are taking care of those values. So, good
> >> >> to get my obvious laziness fixed.
> >> >> 
> >> >
> >> >Sure :)
> >> >
> >> >> I tried your patch on a 40Gbs Ethernet link (Chelsio cxgb4
> >driver).
> >> >> Works in principle, but reported numbers are off. I am not
> >saying
> >> >> I would get right numbers when using Chelsio HW iWarp
> >(iw_cxgb4),
> >> >> but it's closer to reality (using ibv_devinfo <ibname> -vv)
> >> >> 
> >> >> iw_cxgb4 driver:
> >> >> ...
> >> >>    active_width:           4X (2)
> >> >>    active_speed:           25.0 Gbps (32)
> >> >> 
> >> >> siw driver with your patch:
> >> >> ...
> >> >>    active_width:           4X (2)
> >> >>    active_speed:           10.0 Gbps (8)
> >> >> 
> >> >> Any idea how we can improve that, maybe coming even
> >> >> close to reality (40Gbs)?
> >> >
> >> >Could you please share the output of ethtool <if_name> for the
> >> >underlying
> >> >net device that used for both iw_cxgb4 and siw?
> >> >
> >> H Kamal,
> >> 
> >> Sure! Speed looks correct, and its also what I get
> >> at maximum:
> >> 
> >> [bmt@spoke ~]$ ethtool enp1s0f4 
> >> Settings for enp1s0f4:
> >>         Supported ports: [ FIBRE ]
> >>         Supported link modes:   40000baseSR4/Full 
> >>         Supported pause frame use: Symmetric
> >>         Supports auto-negotiation: Yes
> >>         Supported FEC modes: None
> >>         Advertised link modes:  40000baseSR4/Full 
> >>         Advertised pause frame use: Symmetric
> >>         Advertised auto-negotiation: Yes
> >>         Advertised FEC modes: None
> >>         Link partner advertised link modes:  40000baseSR4/Full 
> >>         Link partner advertised pause frame use: Symmetric
> >>         Link partner advertised auto-negotiation: Yes
> >>         Link partner advertised FEC modes: None
> >>         Speed: 40000Mb/s
> >>         Duplex: Full
> >>         Port: Direct Attach Copper
> >>         PHYAD: 255
> >>         Transceiver: internal
> >>         Auto-negotiation: on
> >> Cannot get wake-on-lan settings: Operation not permitted
> >>         Current message level: 0x000000ff (255)
> >>                                drv probe link timer ifdown ifup
> >rx_err tx_err
> >>         Link detected: yes
> >>
> >
> >Hi Bernard,
> >
> >Well, this is the expected value for 40GbE, Because the reported
> >value
> >is 4X aggregation of FDR10. For more info please the table of speeds
> >under [1].
> >
> >[1] -
> >https://urldefense.proofpoint.com/v2/url?u=https-3A__en.wikipedia.org
> >_wiki_InfiniBand&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-r8ZO1PP
> >1alNwU_QJcRRLfmYTAgd3QCvqSc&m=Ay2tYZ7Z-SHKRw8UZDCk76kwlZzvkXhRMrO_0jk
> >YjcY&s=D4Z0CAH5UVO95WHNnUozLzrqjxRQgVe-2lc8_jwVlhw&e= 
> >
> >Thanks,
> >Kamal
> >
> Hi Kamal, so I have to do the math! 4 x 10Gbs = 40Gbs.
> So it is all correct as reported by ibv_devinfio
> (and somehow strange what the iw_cxgb4 makes out of it).
Hi Bernard,
Are you running siw and iw_cxgb4 on the same port or different ports?
if not same, Is the port running iw_cxgb4 connected with 100G cable?
If 40G cable is conencted to iw_cxgb4 as well then its reporting wrong.

Thanks.

> 
> Many thanks for the info,
> Bernard.
> 
