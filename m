Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3722618D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgGTOFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 10:05:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGTOFO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 10:05:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KDvEvU110878;
        Mon, 20 Jul 2020 14:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rKMdX/DUn2df5lmiMcnYSs/bFTq8LES7iH5MmqJ56sI=;
 b=GqoHw8yhhiV1UiXyXWu1wUUnotIqIb1quLZfPM9NKPTjTLkVVmLlVhpkloackUuOFspY
 zaaoa/qE5HaZB7h21PEN02FISBUPtcU/B8AsmYE/hNkbKPU80UgUuzFHEHF96G86W0nV
 oVc3DR2HbIbMfUiIw44EeoJZf+Rmbg2QvOJNee6hNenNyS4bVAfF+AfRs1Ja5t1BsVZC
 FW3YddvcJoBqMcqD4JL//0lVme0sKWn9VrvyFwCfIHxtJowGCYYGv2kzVZ6VDVX2U8or
 yxbi2PVkDJH2iHI++P57S9WzGx+r2Y9j+DVTDaSDkPEbk8ATZFp6FzAI8Cqz2a9lJ+U5 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32bs1m75ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 14:05:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KDw8Ad079580;
        Mon, 20 Jul 2020 14:05:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32d9wbab6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 14:05:11 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KE5Awe004495;
        Mon, 20 Jul 2020 14:05:10 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 14:05:10 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RFC 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200720140013.GG25301@ziepe.ca>
Date:   Mon, 20 Jul 2020 10:05:09 -0400
Cc:     linux-rdma@vger.kernel.org, aron.silverton@oracle.com
Content-Transfer-Encoding: 7bit
Message-Id: <C478FD1F-CBA5-418B-B55D-37B5F4FF7408@oracle.com>
References: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
 <20200710151737.GZ25301@ziepe.ca>
 <1CE2FD8B-8A27-4623-ABA0-D7E830E83D7D@oracle.com>
 <20200720140013.GG25301@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200098
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 20, 2020, at 10:00 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Fri, Jul 10, 2020 at 12:32:28PM -0400, Chuck Lever wrote:
>> 
>> 
>>> On Jul 10, 2020, at 11:17 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>> 
>>> On Fri, Jul 10, 2020 at 10:06:01AM -0400, Chuck Lever wrote:
>>>> Hi-
>>>> 
>>>> This is a Request For Comments.
>>>> 
>>>> Oracle has an interest in a common observability infrastructure in
>>>> the RDMA core and ULPs. One alternative for this infrastructure is
>>>> to introduce static tracepoints that can also be used as hooks for
>>>> eBPF scripts, replacing infrastructure that is based on printk.
>>> 
>>> Don't we already have tracepoints in CM, why is adding more RFC?
>> 
>> One of these patches _replaces_ printk calls with tracepoints.
>> Is that OK?
> 
> Seems OK? I'd rather have the trace points be self consistent than a mix
> of things spilling into pr_debug.

Exactly, but I wanted to be sure the community (and especially authors
of driver/infiniband/core/cm.c) agrees with this view.

I will follow up with a v2 this week with a few fixes and tweaks.


> If someone wants to debug the CM it is clearly better to use the
> complete set of tracepoints, right?


--
Chuck Lever



