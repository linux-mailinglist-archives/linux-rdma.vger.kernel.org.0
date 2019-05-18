Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1F22125
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2019 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfERBde (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 21:33:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfERBde (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 May 2019 21:33:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4I1QFnS178491;
        Sat, 18 May 2019 01:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qhp1tyKTM9kDerqhnFlIc+69/KwePb8zQJn0QCDTDnU=;
 b=yDSxqkfuPvlaytmuZuObhvHIFlsFhNR0n0/uhcFyKac2wth7EO4r8YJVuSLXx52oiw54
 v0THbwNfWfDRDsE/nkHHPL8aeTlo6VDjriaomJ6oSPx8lenESn5erRJM3tY1+r5v9Bqt
 WpQZ3e0/vM7nAUm+FG5nJJgBT+bGMVwT67oFkZGGjzjF35NOKnPS5WF6EKsYKU0hdGes
 lK855t8dSNsj+UffOicpmlxArRQcd9nsEc7IJE/+rDtsSOyqAKbVb8ypXXgjh1pO4ydC
 5oRzwQFKKa+W7kzDQzpiXvPwQ08XB6zS5eaWyhQ2zQPGdrOvkyPtYiz6FWtqx+FCvUHz Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2sdq1r4k5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 May 2019 01:33:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4I1Wsdx117653;
        Sat, 18 May 2019 01:33:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2sj75s8jvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 May 2019 01:33:30 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4I1XTBV031124;
        Sat, 18 May 2019 01:33:29 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 May 2019 01:33:29 +0000
Subject: Re: rdma-core debian packages
To:     Leon Romanovsky <leon@kernel.org>,
        Steve Wise <larrystevenwise@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
 <20190517182129.GA5822@mtr-leonro.mtl.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <49901cc5-6fbc-c540-dbb3-1b3f23f1d689@oracle.com>
Date:   Sat, 18 May 2019 09:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517182129.GA5822@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9260 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905180009
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9260 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905180009
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/5/18 2:21, Leon Romanovsky wrote:
> On Fri, May 17, 2019 at 09:14:13AM -0500, Steve Wise wrote:
>> Hey,
>>
>> Is there a how-to somewhere on building the Debian rdma-core packages?
> There buildlib/cbuild script exactly for that.
>
> 0. Install docker.
> 1. Commit your changes which you want to package.
> 2. ./buildlib/cbuild build-images supported_os_from_the_list
> 3. ./buildlib/cbuild make supported_os_from_the_list
> 4. ./buildlib/cbuild pkg supported_os_from_the_list
> 5. See RPMs or DEBs in ../
>
> Repeat 3 and 4 till you will be satisfied with result.

1. git clone git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

2. cd rdma

3. make menuconfig

4. git am your-patch

5. make -j8 bindeb-pkg

Zhu Yanjun

>
> Thanks
>
>> Thanks,
>>
>> Steve.
