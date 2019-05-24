Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0638E29DF5
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfEXSU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 14:20:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfEXSU4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 14:20:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OIJ4Qo191241;
        Fri, 24 May 2019 18:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Jn/zNbejxo4j407XYA/a3zAoXeqmq9bV0xCwVDwvPNk=;
 b=MaZ/IRtZB1Jl8gRSyQWsfaDArzgCOMa38ertoncbMNysHoK1ELXXwmeFCcMXC6X2v/FA
 XfmEk5VQb7PNMFzb542OMx/B/jpOJnlUMqTjfNEOTvVVJhUGdckHRK7btZ0qROcJ8hrG
 GlyXs2Y03XwhwNRXLQ7YYfo4UGVjNuiZqncfsnLvK5BM5vrBrMiR/83YjcB4yIKKFjW0
 ETO/yhBGFeUa6AC8HxsXLdHwsw7IeLdFTzp7cWs8ftObTwxqTEpaUe3Jupwu0JKR8AuE
 jkzh1Fxdmja/SMiKJ0oZ7C9nzMAn1oUeCSjV7L6478S2QpmXrXPKACagnSYheVwykx7Y lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2smsk5js6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 18:20:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OIKBdf036374;
        Fri, 24 May 2019 18:20:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2smsh31pge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 18:20:54 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4OIKqIZ013580;
        Fri, 24 May 2019 18:20:53 GMT
Received: from [10.211.55.11] (/10.211.55.11)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 18:20:52 +0000
Subject: Re: <infiniband/verbs.h> & ICC
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>,
        "ZUOYU.TAO" <zuoyu.tao@oracle.com>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
 <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
 <20190524150707.GC16845@ziepe.ca>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <2b1565e9-b262-e31d-cfec-6ca1da189090@oracle.com>
Date:   Fri, 24 May 2019 11:20:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524150707.GC16845@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On 24/05/2019 08.07, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 11:14:42PM -0700, Gerd Rausch wrote:
> 
>> I can't say that I'm thrilled with this behavior though,
>> as it appears error-prone:
>> As soon as an enum value goes out of range for an "int", the
>> type silently changes, potentially rendering structures and functions silently incompatible.
>> It's quite the pitfall (e.g. the foo.c vs bar.c case above).
> 
> Indeed, I would be very careful using this extension with
> non-anonymous enums :)
> 
> However, an anonymous enum can never have storage allocated, so it
> doesn't experience any ABI concern.
> 

Sure it can:

% cat foo.c
struct foo {
	enum { FOO = 1UL << 31 } foo;
} foo = { FOO };

% gcc -Wall -g -c foo.c && gdb -batch -ex 'print sizeof foo' foo.o
$1 = 4

% cat bar.c
struct bar {
	enum { FOO = 1UL << 31, BAR = -1 } bar;
} bar = { BAR };

% gcc -Wall -g -c bar.c && gdb -batch -ex 'print sizeof bar' bar.o
$1 = 8


> It is a good and very useful extension, it is unfortuntate that C11
> did not standardize it. (C++11 did though)
> 

Thanks for the info again.
I guess I'm still stuck in 99 ;-)

Cheers,

  Gerd

