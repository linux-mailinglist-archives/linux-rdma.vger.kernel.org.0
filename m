Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30187102A78
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKSRHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 12:07:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKSRHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 12:07:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJGsTqT112670;
        Tue, 19 Nov 2019 17:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=w1eei1hZoUI0m62iwdrQhbOZrycKSzcIm9ieHShuiyQ=;
 b=fAa1OSo0e2US1kgxhb7zceRs/dKSXG8W7pvvYiMwipPe6MeSsWycIKE+KGVmo0I42Wt3
 s6Fda+kx4IH1UBDiA+oqw3elbFCK1jXSpM/r0Gxw+sXaiscc/GyJza28YSIiLJeFDXtG
 wcN9+TjiMOxNUWVZHbKsdbEkd2zl+kJIt3uCrR/5nEO4SJZ6Lvf7cssyivfEovDA2BCx
 eIcF5kl22rE5D/f2VFS8bM2+Tpb2/18o5U198TiLV8x0NgVIW+ufeO/FJLgGYVVsaJC+
 mz7IdOKdpYS2wiSxX5igS41jnc7GbyyrMuVY00DvKJMnkjpI/2zRC6/gAFDijAA5jRDq WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rqg8ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 17:07:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJGsRL6095385;
        Tue, 19 Nov 2019 17:07:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wcema2gbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 17:07:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJH7Eut021522;
        Tue, 19 Nov 2019 17:07:15 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 09:07:14 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 1/2] RDMA/core: Trace points for diagnosing completion
 queue issues
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191119170141.GE4991@ziepe.ca>
Date:   Tue, 19 Nov 2019 12:07:13 -0500
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7E8981E6-71F4-4CC8-A30A-7E08338C6D75@oracle.com>
References: <20191118214447.27891.58814.stgit@manet.1015granger.net>
 <20191118214906.27891.14380.stgit@manet.1015granger.net>
 <20191119170141.GE4991@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190148
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Nov 19, 2019, at 12:01 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Mon, Nov 18, 2019 at 04:49:09PM -0500, Chuck Lever wrote:
>> @@ -65,11 +68,35 @@ static void rdma_dim_init(struct ib_cq *cq)
>> 	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
>> }
>> 
>> +/**
>> + * ib_poll_cq - poll a CQ for completion(s)
>> + * @cq: the CQ being polled
>> + * @num_entries: maximum number of completions to return
>> + * @wc: array of at least @num_entries &struct ib_wc where completions
>> + *      will be returned
>> + *
>> + * Poll a CQ for (possibly multiple) completions.  If the return value
>> + * is < 0, an error occurred.  If the return value is >= 0, it is the
>> + * number of completions returned.  If the return value is
>> + * non-negative and < num_entries, then the CQ was emptied.
>> + */
>> +int ib_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
>> +{
>> +	int rc;
>> +
>> +	rc = cq->device->ops.poll_cq(cq, num_entries, wc);
>> +	trace_cq_poll(cq, num_entries, rc);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL(ib_poll_cq);
> 
> Back to the non-inlined function?

I never got a clear answer about your preference either way.

IMO making this into a non-inline function is necessary to support
either a static trace point here, or to have a place to put a
convenient dynamic trace point via eBPF. I don't believe it will
add noticeable overhead -- in particular, under heavy load, poll_cq
is invoked once every 16 completions.

On the other hand, it's not clear to me that the latency calculation
will work correctly with callers outside of cq.c ...

--
Chuck Lever



