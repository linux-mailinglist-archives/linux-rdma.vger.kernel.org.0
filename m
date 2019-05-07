Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591FC16935
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfEGR2x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 13:28:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:38672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfEGR2x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 13:28:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 10:28:52 -0700
X-ExtLoop1: 1
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2019 10:28:50 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 7 May 2019 10:28:50 -0700
Received: from fmsmsx121.amr.corp.intel.com ([169.254.6.250]) by
 fmsmsx122.amr.corp.intel.com ([169.254.5.42]) with mapi id 14.03.0415.000;
 Tue, 7 May 2019 10:28:50 -0700
From:   "Williams, Gerald S" <gerald.s.williams@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: RE: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Thread-Topic: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Thread-Index: AQHVBEePRBhkoc1BHkSQ8BmFu9mSm6Ze/pcAgADgwvA=
Date:   Tue, 7 May 2019 17:28:50 +0000
Message-ID: <4212415DE1138C4D8CECD226937EE5C772F1BBF3@fmsmsx121.amr.corp.intel.com>
References: <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
 <20190506181610.GB6201@ziepe.ca> <20190506190356.GO6938@mtr-leonro.mtl.com>
 <20190506200849.GF6201@ziepe.ca>
 <7C7AD392-B9EE-41D8-92C9-D09037E8B6E5@oracle.com>
In-Reply-To: <7C7AD392-B9EE-41D8-92C9-D09037E8B6E5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWMwYmFlMmItZTE2NS00ZmQ5LWIwYWMtNWQ2N2YyOTVmNWUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2JxaHBGdlY1UktpU3J6WGlsRnA1bFM5YlVcL0ZZYW8xNWZhSUN1MGlYbSt2cGxEaDVYS3N2RTF3Y3Y2NndhSWIifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On May 06, 2019 at 4:19 PM, Chuck Lever <chuck.level@oracle> wrote:
> On May 6, 2019, at 4:08 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> On Mon, May 06, 2019 at 10:03:56PM +0300, Leon Romanovsky wrote:
>>> On Mon, May 06, 2019 at 03:16:10PM -0300, Jason Gunthorpe wrote:
>>>> On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
>>>>> Don't lose sight of the fact that the additional of the
>>>>> WQ_MEM_RECLAIM is to silence a warning BECAUSE ipoib's workqueue is
>>>>> WQ_MEM_RECLAIM.  This happens while
>>>>> rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by
>>>>> the QP's send engine
>>>>
>>>> Well, it is doing unsafe memory allocations and other stuff, so it
>>>> can't be RECLAIM. We should just delete them from IPoIB like Doug says.
>>>
>>> Please don't.
>>
>> Well then fix the broken allocations it does, and I don't really see
>> how to do that. We can't have it both ways.
>>
>> I would rather have NFS be broken then normal systems with ipoib
>> hanging during reclaim.
>
> TBH, NFS on IPoIB is a hack that I would be happy to see replaced with
> NFS/RDMA. However, I don't think we can have it regressing at this point -
> - and it sounds like there are other use cases that do depend on
> WQ_MEM_RECLAIM remaining in the IPoIB path.

I don't have an opinion on whether it is better to specify WQ_MEM_RECLAIM or not, although we are encountering a regression in the hfi1 driver when it is set. I have been debugging an issue that started happening during certain high-stress conditions after we added the WQ_MEM_RECLAIM attribute to our workqueue.

We need to understand this issue, especially if it turns out to be a workqueue bug/restriction, if we're going to propagate WQ_MEM_RECLAIM.

Somewhat-gory WQ-specific details:

The error is detected by the "sanity checks" in destroy_workqueue(), which we call when unloading our driver. A stack dump is reported via WARN_ON and the function (which has no return code) exits without destroying the queue, creating additional errors later. The specific test that is failing is on the pwq reference count:

	WARN_ON((pwq != wq->dfl_pwq) && (pwq->refcnt > 1))

That reference count is incremented by get_pwq(), which is called when adding work to the queue. It is also called by "mayday" handling in the send_mayday() function from the pool_mayday_timeout() timer handler and from within rescuer_thread() in some situations. rescuer_thread() also calls put_pwq() later to decrement the reference count.

By instrumenting workqueue.c, I determined that we are not adding any work to the queue at the time of the error (and that the queue is empty when the error occurs), although before that, send_mayday() is occasionally called on our workqueue, followed by the second get_pwq() from rescuer_thread().

This is happening during normal operation, although while the system is heavily loaded. Later, when we try to unload the driver, destroy_workqueue() fails due to the refcnt check, even though the queue is empty.

Here are the relevant checks around the rescuer_thread() call to get_pwq() that increments refcnt:

		if (!list_empty(scheduled)) {
			process_scheduled_works(rescuer);

			/*
			 * The above execution of rescued work items could
			 * have created more to rescue through
			 * pwq_activate_first_delayed() or chained
			 * queueing.  Let's put @pwq back on mayday list so
			 * that such back-to-back work items, which may be
			 * being used to relieve memory pressure, don't
			 * incur MAYDAY_INTERVAL delay inbetween.
			 */
			if (need_to_create_worker(pool)) {
				spin_lock(&wq_mayday_lock);
				get_pwq(pwq);

And here is the relevant code from send_mayday():

	/* mayday mayday mayday */
	if (list_empty(&pwq->mayday_node)) {
		/*
		 * If @pwq is for an unbound wq, its base ref may be put at
		 * any time due to an attribute change.  Pin @pwq until the
		 * rescuer is done with it.
		 */
		get_pwq(pwq);

To me, the comment in the latter seems to imply that the reference count is being incremented to keep the pwq alive. However, looking through the code, that does not appear to be how it works. destroy_workqueue() tries to flush it, but if the queue is empty yet refcnt is still greater than 1, it fails. Maybe there's something else going on behind the scenes that I don't understand here.

I am trying to understand what is going wrong and whether there is something we can do about it. I'm hoping Tejun can provide some guidance into investigating this issue, otherwise we may need to move the discussion over to lkml or something.

--
Gerald Williams

