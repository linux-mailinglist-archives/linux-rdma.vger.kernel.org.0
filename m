Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2C965F6
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfHTQMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 20 Aug 2019 12:12:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbfHTQMG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 12:12:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KFoPpp082387
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 12:12:05 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugkj81rxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 12:12:04 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 20 Aug 2019 16:12:04 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 20 Aug 2019 16:11:59 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019082016115836-773461 ;
          Tue, 20 Aug 2019 16:11:58 +0000 
In-Reply-To: <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
Subject: Re: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, dan.carpenter@oracle.com, jgg@ziepe.ca
Date:   Tue, 20 Aug 2019 16:11:58 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>,<20190819140257.19319-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 32655
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082016-1335-0000-0000-000001151B19
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.002411
X-IBM-SpamModules-Versions: BY=3.00011624; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249583; UDB=6.00659668; IPR=6.01031133;
 MB=3.00028248; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-20 16:12:02
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-20 15:18:11 - 6.00010308
x-cbparentid: 19082016-1336-0000-0000-000002C04210
Message-Id: <OF86B144B0.ABBDC503-ON0025845C.0058FCC1-0025845C.0058FCC7@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
>linux-rdma@vger.kernel.org
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 08/20/2019 06:05PM
>Cc: dan.carpenter@oracle.com, jgg@ziepe.ca
>Subject: [EXTERNAL] Re: [PATCH] siw: Fix potential NULL pointer in
>siw_connect().
>
>On Mon, 2019-08-19 at 16:02 +0200, Bernard Metzler wrote:
>> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_cm.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>> index 9ce8a1b925d2..fc97571a640b 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -1515,7 +1515,7 @@ int siw_connect(struct iw_cm_id *id, struct
>> iw_cm_conn_param *params)
>>  		}
>>  	}
>>  error:
>> -	siw_dbg_qp(qp, "failed: %d\n", rv);
>> +	siw_dbg(id->device, "failed: %d\n", rv);
>>  
>>  	if (cep) {
>>  		siw_socket_disassoc(s);
>> @@ -1540,7 +1540,8 @@ int siw_connect(struct iw_cm_id *id, struct
>> iw_cm_conn_param *params)
>>  	} else if (s) {
>>  		sock_release(s);
>>  	}
>> -	siw_qp_put(qp);
>> +	if (qp)
>> +		siw_qp_put(qp);
>>  
>>  	return rv;
>>  }
>
>Hi Bernard,
>
>We try to avoid empty commit messages.  I know in this case the
>subject
>really carries the important info, but it looks better when
>displaying
>the commit if there is something in the message body.
>
>Also, please preface the subject with RDMA/siw: as we like to have
>the
>RDMA subsystem preface the individual subcomponent element in the
>subject line (some people still use IB, which is what used to be
>preferred, but RDMA is preferred today).
>
>I fixed both of those things up and applied this to for-rc, thanks.
>
>Please take a look (I pushed it out to my wip/dl-for-rc branch) so
>you
>can see what I mean about how to make both a simple subject line and
>a
>decent commit message.  Also, no final punctuation on the subject
>line,
>and try to keep the subject length <= 50 chars total.  If you have to
>go
>over to have a decent subject, then so be it, but we strive for that
>50
>char limit to make a subject stay on one line when displayed using
>git
>log --oneline.
>

Hi Doug,

I'll print that email and put it at the wall, right above the screen.
Thanks so much for making it clear even to people like me!

Best regards,
Bernard

