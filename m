Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F128C9D2D6
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfHZPdX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 26 Aug 2019 11:33:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728350AbfHZPdW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 11:33:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFTH2F017591
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 11:33:21 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umfqpxp9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 11:33:21 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 26 Aug 2019 15:33:20 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 26 Aug 2019 15:33:15 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019082615331499-584450 ;
          Mon, 26 Aug 2019 15:33:14 +0000 
In-Reply-To: <20190826151445.GD27349@ziepe.ca>
Subject: Re: Re: Re: [PATCH] RDMA/siw: Fix IPv6 addr_list locking
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, dledford@redhat.com
Date:   Mon, 26 Aug 2019 15:33:15 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190826151445.GD27349@ziepe.ca>,<20190826142520.GB27349@ziepe.ca>
 <20190826141740.12969-1-bmt@zurich.ibm.com>
 <OF9B978FE2.360D6425-ON00258462.00521BE6-00258462.00538708@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 16359
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082615-4409-0000-0000-0000004FB106
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00011660; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01252405; UDB=6.00661386; IPR=6.01033998;
 MB=3.00028341; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-26 15:33:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-26 11:52:38 - 6.00010332
x-cbparentid: 19082615-4410-0000-0000-00000075CD94
Message-Id: <OF574ECC9B.8AFD3804-ON00258462.005507F5-00258462.00557115@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/26/2019 05:14PM
>Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org,
>dledford@redhat.com
>Subject: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Fix IPv6 addr_list
>locking
>
>On Mon, Aug 26, 2019 at 03:12:20PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 08/26/2019 04:25PM
>> >Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org,
>> >dledford@redhat.com
>> >Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix IPv6 addr_list
>locking
>> >
>> >On Mon, Aug 26, 2019 at 04:17:40PM +0200, Bernard Metzler wrote:
>> >> Walking the address list of an inet6_dev requires
>> >> appropriate locking. Since the called function
>> >> siw_listen_address() may sleep, we have to use
>> >> rtnl_lock() + rcu_read_lock_bh() instead of
>> >> read_lock_bh().
>> >
>> >What is the RCU for if you have RTNL?
>> >
>> 
>> Frankly, I looked around in net/ipv6 and found, if not
>> rwlocked, addr_list walking to be rcu protected, even
>> if rtnl_lock()'d (e.g. addrconf_verify_rtnl()).
>> 
>> You are saying this is useless and overdone, since all
>> changes to that list are rtnl_lock protected right?
>> I was not sure about that.
>
>I'm not sure, I thought it was the case that rtnl protected the
>address lists on write.
>
>> For the IPv4 case further up, we also take the rtnl_lock,
>> and RCU-deref the address pointer (via
>> in_dev_for_each_ifa_rtnl()).
>
>That uses rtnl_derference which calls into rcu_dereference_protected
>which is saying 'this RCU protected data is being read outside RCU
>because we are holding the write side lock'
>
>Which means it is locked by RTNL
>
OK, makes sense.

So this is probably really overdone.

Thanks,
Bernard.

