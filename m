Return-Path: <linux-rdma+bounces-176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78D8000F7
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B7628157F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A515C3;
	Fri,  1 Dec 2023 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5iWnCHj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F7D50
	for <linux-rdma@vger.kernel.org>; Thu, 30 Nov 2023 17:29:27 -0800 (PST)
Message-ID: <49c3a285-1467-addf-0eec-736886e48434@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701394165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jd/zbofT6D8EwZSxxH1eccKYmLeToXsmdAwHXewLR1w=;
	b=f5iWnCHj6vsuuacwYA3dmUnOZi9934rsVQEBMDDjNeAc7kySMxjU+xTspM/2BjY5ZPgMRv
	Yr2/rZXNz9Hbw1lr5c3MCmckMWJ70U/A2LHXr9jvA73pU27CvwShswrLCnEavV1kRCKGW4
	u+4u9Oi7hgYYAenZhyF1o3O0Ms3tY5E=
Date: Fri, 1 Dec 2023 09:29:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] RDMA/siw: Set qp_state in siw_query_qp
To: Bernard Metzler <BMT@zurich.ibm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "leon@kernel.org" <leon@kernel.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
 <20231129032418.26705-4-guoqing.jiang@linux.dev>
 <BY5PR15MB3602998251455B5F504978F39982A@BY5PR15MB3602.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <BY5PR15MB3602998251455B5F504978F39982A@BY5PR15MB3602.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Bernard,

On 12/1/23 02:09, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Wednesday, November 29, 2023 4:24 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org; guoqing.jiang@linux.dev
>> Subject: [EXTERNAL] [PATCH 3/4] RDMA/siw: Set qp_state in siw_query_qp
>>
>> Run test_query_rc_qp against siw failed since siw didn't set qp_state
>> accordingly. To address it, introduce siw_qp_state_to_ib_qp_state
>> which convert SIW_QP_STATE_IDLE to IB_QPS_INIT which is similar as
>> in cxgb4.
>>
>> rdma-core# ./build/bin/run_tests.py --dev siw0
>> tests.test_qp.QPTest.test_query_rc_qp -v
>> test_query_rc_qp (tests.test_qp.QPTest)
>> Queries an RC QP after creation. Verifies that its properties are as ...
>> FAIL
>>
>> ======================================================================
>> FAIL: test_query_rc_qp (tests.test_qp.QPTest)
>> Queries an RC QP after creation. Verifies that its properties are as
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>    File "/home/gjiang/rdma-core/tests/test_qp.py", line 284, in
>> test_query_rc_qp
>>      self.query_qp_common_test(e.IBV_QPT_RC)
>>    File "/home/gjiang/rdma-core/tests/test_qp.py", line 265, in
>> query_qp_common_test
>>      self.verify_qp_attrs(caps, e.IBV_QPS_INIT, qp_init_attr, qp_attr)
>>    File "/home/gjiang/rdma-core/tests/test_qp.py", line 239, in
>> verify_qp_attrs
>>      self.assertEqual(state, attr.qp_state)
>> AssertionError: <ibv_qp_state.IBV_QPS_INIT: 1> != 0
>>
>> ----------------------------------------------------------------------
>> Ran 1 test in 0.057s
>>
>> FAILED (failures=1)
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Very nice finding! How could that remain undetected.
> Probably no real application checks QP state 😉

My guess is no one run the test after the commit 😉.

698f2ae80476 tests: Fix comparing qp_state for iWARP providers.

>> ---
>>   drivers/infiniband/sw/siw/siw_verbs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> b/drivers/infiniband/sw/siw/siw_verbs.c
>> index dca6a155523d..233985434cfd 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -19,6 +19,15 @@
>>   #include "siw_verbs.h"
>>   #include "siw_mem.h"
>>
>> +static int siw_qp_state_to_ib_qp_state[IB_QPS_ERR] = {
> You may better use SIW_QP_STATE_COUNT for the size
> of the array

Right, fully agree, will change it in next version after you finish
review this version.

Thanks,
Guoqing

