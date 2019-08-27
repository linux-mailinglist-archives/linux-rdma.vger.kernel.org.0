Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AACB9F5C2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfH0WCB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 27 Aug 2019 18:02:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbfH0WCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 18:02:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RLvsBJ007576
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 18:02:00 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unap0nnyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 18:02:00 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 27 Aug 2019 22:01:59 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 27 Aug 2019 22:01:55 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019082722015441-871045 ;
          Tue, 27 Aug 2019 22:01:54 +0000 
In-Reply-To: <20190827170014.GE7149@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, dledford@redhat.com
Date:   Tue, 27 Aug 2019 22:01:54 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190827170014.GE7149@ziepe.ca>,<20190827164955.9249-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 8277E452:BD63BE1B-00258463:00790602;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 54511
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082722-1639-0000-0000-0000004318E6
X-IBM-SpamModules-Scores: BY=0.02042; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011668; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01253009; UDB=6.00661752; IPR=6.01034607;
 MB=3.00028363; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-27 22:01:58
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-27 17:37:34 - 6.00010337
x-cbparentid: 19082722-1640-0000-0000-0000006B3494
Message-Id: <OF8277E452.BD63BE1B-ON00258463.00790602-00258463.0079060A@notes.na.collabserv.com>
Subject: RE: [PATCH v2] RDMA/siw: Fix IPv6 addr_list locking
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/27/2019 07:28PM
>Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org,
>dledford@redhat.com
>Subject: [EXTERNAL] Re: [PATCH v2] RDMA/siw: Fix IPv6 addr_list
>locking
>
>On Tue, Aug 27, 2019 at 06:49:55PM +0200, Bernard Metzler wrote:
>> Walking the address list of an inet6_dev requires
>> appropriate locking. Since the called function
>> siw_listen_address() may sleep, we have to use
>> rtnl_lock() instead of read_lock_bh().
>> 
>> Also introduces:
>> - sanity checks if we got a device from
>>   in_dev_get() or in6_dev_get().
>> - skipping IPv6 addresses flagged IFA_F_TENTATIVE
>>   or IFA_F_DEPRECATED
>> 
>> Reported-by: Bart Van Assche <bvanassche@acm.org>
>> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>>  drivers/infiniband/sw/siw/siw_cm.c | 33
>+++++++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>> index 1db5ad3d9580..c145b4ff4556 100644
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -1962,6 +1962,10 @@ int siw_create_listen(struct iw_cm_id *id,
>int backlog)
>>  		struct sockaddr_in s_laddr, *s_raddr;
>>  		const struct in_ifaddr *ifa;
>>  
>> +		if (!in_dev) {
>> +			rv = -ENODEV;
>> +			goto out;
>> +		}
>>  		memcpy(&s_laddr, &id->local_addr, sizeof(s_laddr));
>>  		s_raddr = (struct sockaddr_in *)&id->remote_addr;
>>  
>> @@ -1991,22 +1995,27 @@ int siw_create_listen(struct iw_cm_id *id,
>int backlog)
>>  		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr),
>>  			*s_raddr = &to_sockaddr_in6(id->remote_addr);
>>  
>> +		if (!in6_dev) {
>> +			rv = -ENODEV;
>> +			goto out;
>> +		}
>>  		siw_dbg(id->device,
>>  			"laddr %pI6:%d, raddr %pI6:%d\n",
>>  			&s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
>>  			&s_raddr->sin6_addr, ntohs(s_raddr->sin6_port));
>>  
>> -		read_lock_bh(&in6_dev->lock);
>> -		list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
>> -			struct sockaddr_in6 bind_addr;
>> -
>> +		rtnl_lock();
>> +		list_for_each_entry_rcu(ifp, &in6_dev->addr_list, if_list) {
>
>If not holding RCU then don't use the rcu list iterator..
>

absolutely!

