Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F380290D1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 08:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfEXGOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 02:14:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46244 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfEXGOu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 02:14:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O69Clk157553;
        Fri, 24 May 2019 06:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Rhw2c7xgpuVuRq2dji++5N/o0ohzXJQLXmUSZWfoC2s=;
 b=eWQkjP5G4FqLT+Nh26EFNnoYJxs2uvgCMWajuYf/OWoDeI3OZGD/+yojA3yaPyjPB/81
 1EVYpe/pZmbJvEB5BqOYKscmLHMDtDI4g6fm+YKnoCy1MYS43AQRH7NOt8/cZ+CgAxs3
 jB7V/2oe2pURfpHk+rdtRby1l703FjAvbo9sfsLSNFQkf3Qk4y08tZB+H+Kkd4Ejdwc8
 Z5GlZ1LXxhOiN96DF/XRSLhs3xqYuXzL6om6vdwL+ax7teIVnsPAjjQiNOKgvZgQogPT
 iLrdDpbD5n3mfQ+6ul+f80xmGXiPZUA5SxaFVT1oAZwYOE9ENgHfOEWysqthG/Nc6kVr kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2smsk5pt7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 06:14:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O6DlFX176619;
        Fri, 24 May 2019 06:14:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2smsgvx0q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 06:14:44 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4O6Eiqi026817;
        Fri, 24 May 2019 06:14:44 GMT
Received: from [10.159.146.109] (/10.159.146.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 06:14:43 +0000
Subject: Re: <infiniband/verbs.h> & ICC
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>,
        "ZUOYU.TAO" <zuoyu.tao@oracle.com>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
Date:   Thu, 23 May 2019 23:14:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524013033.GA13582@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240042
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+Zuoyu,

Hi Zuoyo,

What compiler flags were you using while compiling the <verbs.h>
file throwing the error about 'enumeration value is out of "int" range'?


On 23/05/2019 18.30, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 03:57:29PM -0700, Gerd Rausch wrote:
>>
>> error: enumeration value is out of "int" range
>>          IBV_RX_HASH_INNER = (1UL << 31),
> 
> I assume you are running with some higher warning flags and -Werror?
> gcc will not emit this warning without -Wpedantic
> 

Perhaps. I've added Zuoyu, who reported this issue
to this e-mail thread.

> 
>> Since "int" is signed, it can't hold the unsigned value of 1UL<<31
>> on target platforms with sizeof(int) <= 4.
> 
> Pedentically yes, but gcc and any compiler that can compile on linux
> supports an extension where the underlying type of an enum constant is
> automatically increased until it can hold the value of the
> constant. In this case the constant is type promoted to long,
> IIRC.
> 

Evidently ICC supports that as well:
% icc --version
icc (ICC) 17.0.5 20170817
Copyright (C) 1985-2017 Intel Corporation.  All rights reserved.

% cat foo.c
enum { FOO = 1UL << 31 } foo = FOO;

% icc -c -g foo.c && gdb -ex 'ptype foo' -ex 'print sizeof foo' foo.o
type = enum {FOO = -2147483648}
$1 = 4

% cat bar.c
enum { FOO = 1UL << 31, BAR = -1 } bar = BAR;
% icc -c -g bar.c && gdb -ex 'ptype bar' -ex 'print sizeof bar' bar.o
type = enum {FOO = -2147483648, BAR = -1}
$1 = 8

I can't say that I'm thrilled with this behavior though,
as it appears error-prone:
As soon as an enum value goes out of range for an "int", the
type silently changes, potentially rendering structures and functions silently incompatible.
It's quite the pitfall (e.g. the foo.c vs bar.c case above).

> 
> Can you clarify if icc is being run in some wonky mode that is causing
> this warning? AFAIK icc will compile the linux kernel, and the kernel
> makes extensive use of this extension. So I think the compiler is not
> configured properly.
> 

I've added Zuoyu to the distribution to shed some light on that.

> IIRC I looked at this once for -Wpedantic support and decided it was a
> lot of work as there are more cases than just this.
> 

Not exactly shocking news ;-)

Thanks for providing the information,

  Gerd
