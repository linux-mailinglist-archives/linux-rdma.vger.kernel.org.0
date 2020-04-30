Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC01C0001
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD3PVO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 11:21:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgD3PVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Apr 2020 11:21:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03UFK9UY121108;
        Thu, 30 Apr 2020 15:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=isXNfaJWhlsytQp6VRK5E83qCU0TB0RoF3/hLzyB+NY=;
 b=w9HvUffde1jK6jSJ3LXHDuUak4caMde1rU81GLcV8ix+sN1BUlu71Y6fvTNTJycsA+oe
 b3LqeTUb2CK8uz65iXBHi6UM4kQRypA/AqepCU3GFv8Slv7kGTPD87fVpJSm/qZ4z5h2
 cvikT5w1bSQPLY1j/Xa1ePl8vPIj4/hPjPVqdsV/LooDc78JVnfh1Jx1TDB2W6CwTHeJ
 hNjChVYedi+GHww3Q5naSYhTM5o+hKxhcmISMNasUjyaTu9wTnkVVDGBJmGf71YAKQyv
 hZHWp9DFzPjkNfLVPiNqUF0Qc+0zRniG6BcS37viOr1dCKiGudPbXASF1BSLfT+jC4uK fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30p01p2mub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 15:21:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03UFITBe077535;
        Thu, 30 Apr 2020 15:19:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30qtkwjx16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 15:19:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03UFJ7Vs025956;
        Thu, 30 Apr 2020 15:19:07 GMT
Received: from dhcp-10-159-141-123.vpn.oracle.com (/10.159.141.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Apr 2020 15:19:06 +0000
Subject: Re: Request for feedback : Possible use-after-free in routing SA
 query via netlink
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>
References: <8fbdf10e-3f08-6407-eb0d-a1bf663873c3@oracle.com>
 <20200424182223.GI26002@ziepe.ca>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <0ca6475a-4f07-44e1-1669-9dd815b521ae@oracle.com>
Date:   Thu, 30 Apr 2020 08:18:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424182223.GI26002@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=11 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=11 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300124
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Thanks for taking the time to review. 

On 4/24/20 11:22 AM, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2020 at 08:28:09AM -0700, Divya Indi wrote:
>
>> If we look at the query, it does not appear to be a valid ib_sa_query. Instead
>> looks like a pid struct for a process -> Use-after-free situation.
>>
>> We could simulate the crash by explicitly introducing a delay in ib_nl_snd_msg with
>> a sleep. The timer kicks in before ib_nl_send_msg has even sent out the request 
>> and releases the query. We could reproduce the crash with a similar stack trace.
>>
>> To summarize - We have a use-after-free possibility here when the timer(ib_nl_request_timeout)
>> kicks in before ib_nl_snd_msg has completed sending the query out to ibacm via netlink. The 
>> timeout handler ie ib_nl_request_timeout may result in releasing the query while ib_nl_snd_msg 
>> is still accessing query.
>>
>> Appreciate your thoughts on the above issue.
> Your assesment looks right to me.
>
> Fixing it will require being able to clearly explain what the lifetime
> cycle is for ib_sa_query - and what is there today looks like a mess,
> so I'm not sure what it should be changed into.

The issue reported here appears to be restricted to the ibacm code path. 
Hence, we tried to resolve it for the life cycle of sa_query in the ibacm code path.
I will follow up this email with a proposed fix(patch), it would be very helpful if
you can provide your feedback on the same.

Thanks,
Divya

>
> The
> re is lots of other stuff there that looks really weird, like
> ib_sa_cancel_query() keeps going even though there are still timers
> running..
>
> Jason
