Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AA1A9EAA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898024AbgDOL7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 Apr 2020 07:59:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2898023AbgDOL7c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 07:59:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FBXiNF124705
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 07:59:31 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30dse2nv1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 07:59:31 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 15 Apr 2020 11:59:30 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 15 Apr 2020 11:59:21 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2020041511592093-392221 ;
          Wed, 15 Apr 2020 11:59:20 +0000 
In-Reply-To: <20200415105135.GA8246@chelsio.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     <faisal.latif@intel.com>, <shiraz.saleem@intel.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, <bharat@chelsio.com>,
        <nirranjan@chelsio.com>
Date:   Wed, 15 Apr 2020 11:59:21 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200415105135.GA8246@chelsio.com>,<20200414144822.2365-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP64 March 05, 2020 at 12:58
X-LLNOutbound: False
X-Disclaimed: 45407
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20041511-9463-0000-0000-000002F90C95
X-IBM-SpamModules-Scores: BY=0.054116; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.054054
X-IBM-SpamModules-Versions: BY=3.00012915; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01362770; UDB=6.00727615; IPR=6.01145137;
 MB=3.00031712; MTD=3.00000008; XFM=3.00000015; UTC=2020-04-15 11:59:27
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-04-15 07:37:29 - 6.00011244
x-cbparentid: 20041511-9464-0000-0000-0000F2CD3FD1
Message-Id: <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
Subject: RE: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO usage.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_02:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, <faisal.latif@intel.com>,
><shiraz.saleem@intel.com>, <mkalderon@marvell.com>,
><aelior@marvell.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 04/15/2020 12:52PM
>Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
><bharat@chelsio.com>, <nirranjan@chelsio.com>
>Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental e2e
>negotiation of GSO usage.
>
>On Tuesday, April 04/14/20, 2020 at 16:48:22 +0200, Bernard Metzler
>wrote:
>> Disabling GS0 usage lets siw create FPDUs fitting MTU size.
>> Enabling GSO usage lets siw form larger FPDUs fitting up to one
>> current GSO frame. As a software only iWarp implementation, for
>> large messages, siw bandwidth performance severly suffers from not
>> using GSO, reducing available single stream bandwidth on fast links
>> by more than 50%, while increasing CPU load.
>> 
>> Experimental GSO usage handshake is implemented by using one spare
>> bit of the MPA header, which is used to signal GSO framing at
>> initiator side and GSO framing acceptance at responder side.
>> Typical iWarp hardware implementations will not set or interpret
>> that header bit. Against such peer, siw will adhere to forming
>> FPDUs fitting with MTU size. This assures interoperability with
>> peer iWarp implementations unable to process FPDUs larger than
>> MTU size.
>> 
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>> index 5cd40fb9e20c..a2dbdbcacf72 100644
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -36,7 +36,7 @@ const bool zcopy_tx = true;
>>   * large packets. try_gso = true lets siw try to use local GSO,
>>   * if peer agrees.  Not using GSO severly limits siw maximum tx
>bandwidth.
>>   */
>> -const bool try_gso;
>> +const bool try_gso = true;
>>  
>>  /* Attach siw also with loopback devices */
>>  const bool loopback_enabled = true;
>> -- 
>> 2.20.1
>> 
>
>Hi Bernard,
>
>As per RFC5044, DDP layer should limit each record size to 
>MULPDU(Maximum ULPDU: The current maximum size of the record that
>is acceptable for DDP to pass to MPA for transmission)" 
>Eg: if physical layer MTU is 1500, then DDP record length should
>be ~1448 Max. All hard iWARP devices defaults to this behaviour, I
>think.
>		   
>So if SoftiWARP constructs FPDU based on this 64KB MSS, then the 

Hi Krishna,

The proposed patch does not nail it to 64K, but dynamically
adapts to what the TCP socket currently advertises.
This may vary over time, at maximum to 64K, or stick to 1.5K,
if advertised so. siw is not an ULP of Ethernet, but TCP, and
takes into account what the current TCP socket says.
TCP advertises to ULPs current maximum segments via
tcp_sock *tp->gso_segs for good reasons.

siw performance sucks when using small FPDUs, since it always
must attach a trailing CRC after any data pages it pushes. Adding
a 4 byte trailer after each data page to be sent seem to put the
kernel network stack far out of its comfort zone.

>hardiWARP peer(say Chesio adapter) should also understand the 64KB
>FPDU.

This is why it is currently disabled.

>At present, Chelsio T6 adapter could understand upto 16KB large FPDU
>size, max.
>
That's interesting and would already better the performance for
siw <-> hardware iwarp substantially I guess. Did you try that?

The siw code already has a hook to limit segment growing below
to what TCP advertises (since I experimented with earlier Chelsio
hardware which was able to accept different max segment sizes,
some up to full GSO (64k)). See siw.h:
u8 gso_seg_limit; /* Maximum segments for GSO, 0 = unbound */

While currently set to 1 during connection establishment for
not using GSO, other values would be respected. A '2' 
with 9k MTU would produce 16K FPDUs max.
 

>So is there a way that the peer(typically hard iWARP) could negotiate
>it's supported ingress FPDU size? instead of fixed 64KB size.
>
Again, it would not be fixed to 64K, but to what TCP tells siw.

In any case, thinking about that would make sense only if there
is interest from hardware side. Is there interest? Probably yes,
since single stream siw <-> siw on a 100Gb link with GSO would
have more than twice the throughput of siw <-> T6 w/o GSO ;)

>Adding other iWARP maintainers for wider audience, to let them share
>their thoughts. And if their adapters also have such ingress FPDU
>size
>limitations then I think allowing peer to negotiate its supported
>ingress
>FPDU size would be more efficient than going with fixed 64KB FPDU
>size.

I agree, would be great to get input from Intel and Marvell
as well...

Thanks for reviewing!
Bernard.

