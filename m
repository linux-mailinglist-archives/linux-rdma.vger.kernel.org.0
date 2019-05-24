Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE429F0E
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 21:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfEXTZm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 15:25:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfEXTZm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 15:25:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OJOQVN046246;
        Fri, 24 May 2019 19:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xxtgJNihH7K87lWD29Xt8z4zdYud+1WoD/6ePIKZLL4=;
 b=vs0GY8n4QPPR+rj9KbX2zCDYQXGiGJGA8fn4w3pI6XhyQ6GuyZG9zT4hS4t2WyRJHAnR
 WpYlLUrhICTpDUwxl8iOJGgnpK1iggEmjZWJyb3wuUo2/OXadHSPZxieGNORL6UAA6jd
 XnNLlsTWPRoGbDOqqkjY968D77yI0Xxz1Td0YwMsHK4BtMMlDLz7gCdGm+/mOHDICkcz
 q4GGfcQKkJqQdqVGtzABTBJLnOAuFLYtg06PzfePqWxMJJxh4G6c5pTubWkhU+sJ+tIz
 pOh/qywIJNNBSOvcTsV8QhUeNr+gsydn6wqSqbaX5KIS5x/6FARlzd8nJoo2RSynxsub Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2smsk5k1xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 19:25:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OJOIwi180549;
        Fri, 24 May 2019 19:25:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2smsh32jug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 19:25:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4OJPZtr031823;
        Fri, 24 May 2019 19:25:35 GMT
Received: from [10.211.55.11] (/10.211.55.11)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 19:25:35 +0000
Subject: Re: <infiniband/verbs.h> & ICC
To:     Zuoyu Tao <zuoyu.tao@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
 <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
 <309e44c2-f520-4e35-9f50-5e6932d7b40f@default>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <d2f25bde-488f-dc37-b751-53ec602d66be@oracle.com>
Date:   Fri, 24 May 2019 12:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <309e44c2-f520-4e35-9f50-5e6932d7b40f@default>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240126
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

It's the "-strict-ansi" that makes it fail:

% icc -c -strict-ansi foo.c
foo.c(2): error: enumeration value is out of "int" range
  	enum { FOO = 1UL << 31 } foo;


Zuoyu, is it possible to _not_ use "-strict-ansi"?

Thanks,

  Gerd

On 24/05/2019 11.59, Zuoyu Tao wrote:
> Here were the compiler flags used with ICC:
> 
> -trigraphs -fno-omit-frame-pointer -fp-model source  -fno-strict-aliasing  -mIPOPT_clone_max_total_clones=0 -mP2OPT_hpo_enable_short_trip_vec=F -sox=profile -sox=inline   -no-global-hoist -mP2OPT_tls_control=0  -wd191 -wd175 -wd188 -wd810 -we127 -we1345 -we1338 -wd279 -wd186 -wd1572 -wd589 -wd11505 -we592 -wd69 -we172 -Qoption,cpp,--treat_func_as_string_literal -mP2OPT_spill_parms=T -wd11505 -wd411 -wd273 -ww174    -we266    -ww279    -we589    -we810    -we1011   -ww1418   -strict-ansi -wd66     -wd76     -wd82     -wd94     -we102    -wd271    -wd424    -wd561    -wd662    -wd1511    -std=c99 -ww344 -we137   -fPIC -mP2OPT_tls_control=2
> 
> -----Original Message-----
> From: Gerd Rausch 
> Sent: Thursday, May 23, 2019 11:15 PM
> To: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; Aron Silverton <aron.silverton@oracle.com>; Sharon Liu <sharon.s.liu@oracle.com>; ZUOYU.TAO <zuoyu.tao@oracle.com>
> Subject: Re: <infiniband/verbs.h> & ICC
> 
> +Zuoyu,
> 
> Hi Zuoyo,
> 
> What compiler flags were you using while compiling the <verbs.h> file throwing the error about 'enumeration value is out of "int" range'?
> 
> 
> On 23/05/2019 18.30, Jason Gunthorpe wrote:
>> On Thu, May 23, 2019 at 03:57:29PM -0700, Gerd Rausch wrote:
>>>
>>> error: enumeration value is out of "int" range
>>>          IBV_RX_HASH_INNER = (1UL << 31),
>>
>> I assume you are running with some higher warning flags and -Werror?
>> gcc will not emit this warning without -Wpedantic
>>
> 
> Perhaps. I've added Zuoyu, who reported this issue to this e-mail thread.
> 
>>
>>> Since "int" is signed, it can't hold the unsigned value of 1UL<<31 on 
>>> target platforms with sizeof(int) <= 4.
>>
>> Pedentically yes, but gcc and any compiler that can compile on linux 
>> supports an extension where the underlying type of an enum constant is 
>> automatically increased until it can hold the value of the constant. 
>> In this case the constant is type promoted to long, IIRC.
>>
> 
> Evidently ICC supports that as well:
> % icc --version
> icc (ICC) 17.0.5 20170817
> Copyright (C) 1985-2017 Intel Corporation.  All rights reserved.
> 
> % cat foo.c
> enum { FOO = 1UL << 31 } foo = FOO;
> 
> % icc -c -g foo.c && gdb -ex 'ptype foo' -ex 'print sizeof foo' foo.o type = enum {FOO = -2147483648}
> $1 = 4
> 
> % cat bar.c
> enum { FOO = 1UL << 31, BAR = -1 } bar = BAR; % icc -c -g bar.c && gdb -ex 'ptype bar' -ex 'print sizeof bar' bar.o type = enum {FOO = -2147483648, BAR = -1}
> $1 = 8
> 
> I can't say that I'm thrilled with this behavior though, as it appears error-prone:
> As soon as an enum value goes out of range for an "int", the type silently changes, potentially rendering structures and functions silently incompatible.
> It's quite the pitfall (e.g. the foo.c vs bar.c case above).
> 
>>
>> Can you clarify if icc is being run in some wonky mode that is causing 
>> this warning? AFAIK icc will compile the linux kernel, and the kernel 
>> makes extensive use of this extension. So I think the compiler is not 
>> configured properly.
>>
> 
> I've added Zuoyu to the distribution to shed some light on that.
> 
>> IIRC I looked at this once for -Wpedantic support and decided it was a 
>> lot of work as there are more cases than just this.
>>
> 
> Not exactly shocking news ;-)
> 
> Thanks for providing the information,
> 
>   Gerd
> 
