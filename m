Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7FB4F80
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 15:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfIQNkT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Sep 2019 09:40:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbfIQNkT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Sep 2019 09:40:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HDdWdU149625
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 09:40:16 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.74])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2xs260e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 09:40:16 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 17 Sep 2019 13:40:14 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 17 Sep 2019 13:40:07 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019091713400681-599055 ;
          Tue, 17 Sep 2019 13:40:06 +0000 
In-Reply-To: <20190917124719.GA11070@chelsio.com>
Subject: Re: Re: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on
 iw_rem_ref
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "Steve Wise" <larrystevenwise@gmail.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>
Date:   Tue, 17 Sep 2019 13:40:07 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190917124719.GA11070@chelsio.com>,<20190916162829.GA22329@ziepe.ca>
 <20190904212531.6488-1-sagi@grimberg.me> <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
 <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 26195
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19091713-3165-0000-0000-000001098024
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000006
X-IBM-SpamModules-Versions: BY=3.00011790; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000291; SDB=6.01262645; UDB=6.00667693; IPR=6.01044506;
 MB=3.00028664; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-17 13:40:12
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-17 10:30:45 - 6.00010417
x-cbparentid: 19091713-3166-0000-0000-00001C3E8EF8
Message-Id: <OF4A250815.36D6F256-ON00258478.00487431-00258478.004B157C@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Steve Wise"
><larrystevenwise@gmail.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 09/17/2019 02:48PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Sagi Grimberg"
><sagi@grimberg.me>, "linux-rdma@vger.kernel.org"
><linux-rdma@vger.kernel.org>, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>
>Subject: [EXTERNAL] Re: Re: Re: [PATCH v3] iwcm: don't hold the irq
>disabled lock on iw_rem_ref
>
>On Tuesday, September 09/17/19, 2019 at 14:34:24 +0530, Bernard
>Metzler wrote:
>> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>> 
>> >To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 09/16/2019 06:28PM
>> >Cc: "Steve Wise" <larrystevenwise@gmail.com>, "Bernard Metzler"
>> ><BMT@zurich.ibm.com>, "Sagi Grimberg" <sagi@grimberg.me>,
>> >"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>> >Subject: [EXTERNAL] Re: Re: [PATCH v3] iwcm: don't hold the irq
>> >disabled lock on iw_rem_ref
>> >
>> >On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju
>> >wrote:
>> >> Hi Steve & Bernard,
>> >> 
>> >> Thanks for the review comments.
>> >> I will do those formating changes.
>> >
>> >I don't see anything in patchworks, but the consensus is to drop
>> >Sagi's patch pending this future patch?
>> >
>> >Jason
>> >
>> This is my impression as well. But consensus should be
>> explicit...Sagi, what do you think?
>> 
>> Best regards,
>> Bernard.
>> 
>While testing iSER(with my proposed patch applied) I see Chelsio
>iwarp
>driver is hitting the below deadlock issue. This is due to iw_rem_ref
>reordering changes in IWCM.
>
>Bernard, how about replacing vmalloc/vfree with kmalloc/kfree,
>such that freeing of SIW qp resources can be done with spinlocks
>held?
>to fix the orginal vfree issue less invasively..

Well, I'd really like to avoid kmalloc on potentially
large data structures when there is no need to have
physically contiguous memory.

I could of course move that vfree out to a worker.
Simple, but not really nice though.

So it seems it would be no good option to restructure
the Chelsio driver?

Thanks
Bernard.

>
>Steve, any suggestions?
>
>
>[ 1230.161871] INFO: task kworker/u12:0:11291 blocked for more than
>122
>seconds.
>[ 1230.162147]       Not tainted 5.3.0-rc5+ #19
>[ 1230.162417] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>disables this message.
>[ 1230.162911] kworker/u12:0   D13000 11291      2 0x80004080
>[ 1230.163186] Workqueue: iw_cm_wq cm_work_handler
>[ 1230.163456] Call Trace:
>[ 1230.163718]  ? __schedule+0x297/0x510
>[ 1230.163986]  schedule+0x2e/0x90
>[ 1230.164253]  schedule_timeout+0x1c0/0x280
>[ 1230.164520]  ? xas_store+0x23e/0x500
>[ 1230.164789]  wait_for_completion+0xa2/0x110
>[ 1230.165067]  ? wake_up_q+0x70/0x70
>[ 1230.165336]  c4iw_destroy_qp+0x141/0x260 [iw_cxgb4]
>[ 1230.165611]  ? xas_store+0x23e/0x500
>[ 1230.165893]  ? _cond_resched+0x10/0x20
>[ 1230.166160]  ? wait_for_completion+0x2e/0x110
>[ 1230.166432]  ib_destroy_qp_user+0x142/0x230
>[ 1230.166699]  rdma_destroy_qp+0x1f/0x40
>[ 1230.166966]  iser_free_ib_conn_res+0x52/0x190 [ib_iser]
>[ 1230.167241]  iser_cleanup_handler.isra.15+0x32/0x60 [ib_iser]
>[ 1230.167510]  iser_cma_handler+0x23b/0x730 [ib_iser]
>[ 1230.167776]  cma_iw_handler+0x154/0x1e0
>[ 1230.168037]  cm_work_handler+0xb4c/0xd60
>[ 1230.168302]  process_one_work+0x155/0x380
>[ 1230.168564]  worker_thread+0x41/0x3b0
>[ 1230.168827]  kthread+0xf3/0x130
>[ 1230.169086]  ? process_one_work+0x380/0x380
>[ 1230.169350]  ? kthread_bind+0x10/0x10
>[ 1230.169615]  ret_from_fork+0x35/0x40
>[ 1230.169885] NMI backtrace for cpu 3
>
>

