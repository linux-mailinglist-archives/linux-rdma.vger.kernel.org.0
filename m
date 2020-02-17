Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E81615F9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2020 16:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBQPSU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 17 Feb 2020 10:18:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727300AbgBQPST (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Feb 2020 10:18:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFFQFP129592
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 10:18:18 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dh42asu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 10:18:18 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 17 Feb 2020 15:18:17 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 17 Feb 2020 15:18:13 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2020021715181202-548070 ;
          Mon, 17 Feb 2020 15:18:12 +0000 
In-Reply-To: <20200217145044.GA1024@chelsio.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Potnuri Bharat Teja" <bharat@chelsio.com>
Cc:     "Kamal Heib" <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Mon, 17 Feb 2020 15:18:12 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200217145044.GA1024@chelsio.com>,<20200217141146.GA1908@kheib-workstation>
 <20200216134249.GA7456@kheib-workstation>
 <20200213130701.11589-1-kamalheib1@gmail.com>
 <OF9565E197.68A7B59D-ON0025850D.0049D122-0025850D.004CDC1C@notes.na.collabserv.com>
 <OF10DED8FF.9794F86F-ON00258511.003822AA-00258511.003827A8@notes.na.collabserv.com>
 <OF2F71177A.B62840BF-ON00258511.004F75BA-00258511.004F75C2@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-LLNOutbound: False
X-Disclaimed: 24683
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20021715-7279-0000-0000-000001FBA094
X-IBM-SpamModules-Scores: BY=0.020255; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.388783; ST=0; TS=0; UL=0; ISC=; MB=0.180022
X-IBM-SpamModules-Versions: BY=3.00012592; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01335264; UDB=6.00711287; IPR=6.01117623;
 MB=3.00030842; MTD=3.00000008; XFM=3.00000015; UTC=2020-02-17 15:18:17
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-02-17 14:46:35 - 6.00011016
x-cbparentid: 20021715-7280-0000-0000-00004EABB67E
Message-Id: <OF75E6C96C.C6405923-ON00258511.0053246F-00258511.00541057@notes.na.collabserv.com>
Subject: RE: [PATH for-next] RDMA/siw: Fix setting active_{speed, width} attributes
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_10:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Potnuri Bharat Teja" <bharat@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Potnuri Bharat Teja" <bharat@chelsio.com>
>Date: 02/17/2020 03:51PM
>Cc: "Kamal Heib" <kamalheib1@gmail.com>, "linux-rdma@vger.kernel.org"
><linux-rdma@vger.kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug
>Ledford" <dledford@redhat.com>
>Subject: [EXTERNAL] Re: [PATH for-next] RDMA/siw: Fix setting
>active_{speed, width} attributes
>
>On Monday, February 02/17/20, 2020 at 19:57:54 +0530, Bernard Metzler
>wrote:
>> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Kamal Heib" <kamalheib1@gmail.com>
>> >Date: 02/17/2020 03:12PM
>> >Cc: linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
>> >"Doug Ledford" <dledford@redhat.com>
>> >Subject: [EXTERNAL] Re: [PATH for-next] RDMA/siw: Fix setting
>> >active_{speed, width} attributes
>> >
>> >On Mon, Feb 17, 2020 at 10:13:21AM +0000, Bernard Metzler wrote:
>> >> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
>> >> 
>> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >> >From: "Kamal Heib" <kamalheib1@gmail.com>
>> >> >Date: 02/16/2020 02:43PM
>> >> >Cc: linux-rdma@vger.kernel.org, "Jason Gunthorpe"
><jgg@ziepe.ca>,
>> >> >"Doug Ledford" <dledford@redhat.com>
>> >> >Subject: [EXTERNAL] Re: [PATH for-next] RDMA/siw: Fix setting
>> >> >active_{speed, width} attributes
>> >> >
>> >> >On Thu, Feb 13, 2020 at 01:59:30PM +0000, Bernard Metzler
>wrote:
>> >> >> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
>> >> >> 
>> >> >> >To: linux-rdma@vger.kernel.org
>> >> >> >From: "Kamal Heib" <kamalheib1@gmail.com>
>> >> >> >Date: 02/13/2020 02:07PM
>> >> >> >Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
>> >> >> ><dledford@redhat.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>,
>> >> >"Kamal
>> >> >> >Heib" <kamalheib1@gmail.com>
>> >> >> >Subject: [EXTERNAL] [PATH for-next] RDMA/siw: Fix setting
>> >> >> >active_{speed, width} attributes
>> >> >> >
>> >> >> >Make sure to set the active_{speed, width} attributes to
>avoid
>> >> >> >reporting
>> >> >> >the same values regardless of the underlying device.
>> >> >> >
>> >> >> >Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>> >> >> >Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> >> >> >---
>> >> >> > drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
>> >> >> > 1 file changed, 4 insertions(+), 3 deletions(-)
>> >> >> >
>> >> >> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >> >b/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >> >index 73485d0da907..b1aaec912edb 100644
>> >> >> >--- a/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >> >@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device
>> >> >*base_dev,
>> >> >> >u8 port,
>> >> >> > 		   struct ib_port_attr *attr)
>> >> >> > {
>> >> >> > 	struct siw_device *sdev = to_siw_dev(base_dev);
>> >> >> >+	int rc;
>> >> >> > 
>> >> >> > 	memset(attr, 0, sizeof(*attr));
>> >> >> > 
>> >> >> >-	attr->active_speed = 2;
>> >> >> >-	attr->active_width = 2;
>> >> >> >+	rc = ib_get_eth_speed(base_dev, port, &attr->active_speed,
>> >> >> >+			 &attr->active_width);
>> >> >> > 	attr->gid_tbl_len = 1;
>> >> >> > 	attr->max_msg_sz = -1;
>> >> >> > 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>> >> >> >@@ -192,7 +193,7 @@ int siw_query_port(struct ib_device
>> >*base_dev,
>> >> >u8
>> >> >> >port,
>> >> >> > 	 * attr->subnet_timeout = 0;
>> >> >> > 	 * attr->init_type_repy = 0;
>> >> >> > 	 */
>> >> >> >-	return 0;
>> >> >> >+	return rc;
>> >> >> > }
>> >> >> > 
>> >> >> > int siw_get_port_immutable(struct ib_device *base_dev, u8
>> >port,
>> >> >> >-- 
>> >> >> >2.21.1
>> >> >> >
>> >> >> >
>> >> >> Hi Kamal, 
>> >> >
>> >> >Hi Bernard,
>> >> >
>> >> >> Many thanks for looking after this! So there definitely seem
>to 
>> >> >> be applications which are taking care of those values. So,
>good
>> >> >> to get my obvious laziness fixed.
>> >> >> 
>> >> >
>> >> >Sure :)
>> >> >
>> >> >> I tried your patch on a 40Gbs Ethernet link (Chelsio cxgb4
>> >driver).
>> >> >> Works in principle, but reported numbers are off. I am not
>> >saying
>> >> >> I would get right numbers when using Chelsio HW iWarp
>> >(iw_cxgb4),
>> >> >> but it's closer to reality (using ibv_devinfo <ibname> -vv)
>> >> >> 
>> >> >> iw_cxgb4 driver:
>> >> >> ...
>> >> >>    active_width:           4X (2)
>> >> >>    active_speed:           25.0 Gbps (32)
>> >> >> 
>> >> >> siw driver with your patch:
>> >> >> ...
>> >> >>    active_width:           4X (2)
>> >> >>    active_speed:           10.0 Gbps (8)
>> >> >> 
>> >> >> Any idea how we can improve that, maybe coming even
>> >> >> close to reality (40Gbs)?
>> >> >
>> >> >Could you please share the output of ethtool <if_name> for the
>> >> >underlying
>> >> >net device that used for both iw_cxgb4 and siw?
>> >> >
>> >> H Kamal,
>> >> 
>> >> Sure! Speed looks correct, and its also what I get
>> >> at maximum:
>> >> 
>> >> [bmt@spoke ~]$ ethtool enp1s0f4 
>> >> Settings for enp1s0f4:
>> >>         Supported ports: [ FIBRE ]
>> >>         Supported link modes:   40000baseSR4/Full 
>> >>         Supported pause frame use: Symmetric
>> >>         Supports auto-negotiation: Yes
>> >>         Supported FEC modes: None
>> >>         Advertised link modes:  40000baseSR4/Full 
>> >>         Advertised pause frame use: Symmetric
>> >>         Advertised auto-negotiation: Yes
>> >>         Advertised FEC modes: None
>> >>         Link partner advertised link modes:  40000baseSR4/Full 
>> >>         Link partner advertised pause frame use: Symmetric
>> >>         Link partner advertised auto-negotiation: Yes
>> >>         Link partner advertised FEC modes: None
>> >>         Speed: 40000Mb/s
>> >>         Duplex: Full
>> >>         Port: Direct Attach Copper
>> >>         PHYAD: 255
>> >>         Transceiver: internal
>> >>         Auto-negotiation: on
>> >> Cannot get wake-on-lan settings: Operation not permitted
>> >>         Current message level: 0x000000ff (255)
>> >>                                drv probe link timer ifdown ifup
>> >rx_err tx_err
>> >>         Link detected: yes
>> >>
>> >
>> >Hi Bernard,
>> >
>> >Well, this is the expected value for 40GbE, Because the reported
>> >value
>> >is 4X aggregation of FDR10. For more info please the table of
>speeds
>> >under [1].
>> >
>> >[1] -
>>
>>https://urldefense.proofpoint.com/v2/url?u=https-3A__en.wikipedia.or
>g
>>
>>_wiki_InfiniBand&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-r8ZO1P
>P
>>
>>1alNwU_QJcRRLfmYTAgd3QCvqSc&m=Ay2tYZ7Z-SHKRw8UZDCk76kwlZzvkXhRMrO_0j
>k
>> >YjcY&s=D4Z0CAH5UVO95WHNnUozLzrqjxRQgVe-2lc8_jwVlhw&e= 
>> >
>> >Thanks,
>> >Kamal
>> >
>> Hi Kamal, so I have to do the math! 4 x 10Gbs = 40Gbs.
>> So it is all correct as reported by ibv_devinfio
>> (and somehow strange what the iw_cxgb4 makes out of it).
>Hi Bernard,
>Are you running siw and iw_cxgb4 on the same port or different ports?
>if not same, Is the port running iw_cxgb4 connected with 100G cable?
>If 40G cable is conencted to iw_cxgb4 as well then its reporting
>wrong.
>
This is a single port 40Gbs setup. All my fault:
For iw_cxgb4, I looked at the reported values for the second
port, which is not physically connected but reported PORT_DOWN
and 4 x 25Gbs.
The connected port 1 has 4 x 10Gbs for both siw and iw_cxgb4.
Sorry about the confusion!

So its all good.

Thanks
Bernard.

