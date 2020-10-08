Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E428727C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgJHKYQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 06:24:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56206 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgJHKYQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 06:24:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098AKO1o025027;
        Thu, 8 Oct 2020 10:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lOG+qb1kBnxVdNfqs6aLmsjK6r8cOF99/h1GWUOb5lA=;
 b=BPMhH/4Czlbu+7r6WiEdaOMbNMiPuq/csItIh8rKRQ0OYCJyb3Hh+2Neoyn0A8eDoNKh
 WriVExBk82aMDRTFjZsxulfFgg/okV51PJanE/EcsWDSCxvTULI+jf6lYglUWwHeMcpx
 fw5bTfLRbHPf6jA3hqZdx52y7VVGj8iKQ6igaKSm3fPBEjc+HIOv0xAQTiHTl2wyZPCI
 KW6gR2Sl9xhLM3/TL0PNmQ+fXjtnWWp0uZrY4BPUAY9oRmCt/FyvhnY4noZFUXEULNxs
 NTfAM4XsKrzfHHUfKan/M9Bla52Spw0Wzg0KOdzbKarh/aRv3GJv5xvappAvuPq7wtkW /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33xetb70yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 10:24:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098AKFJ3091183;
        Thu, 8 Oct 2020 10:22:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33y380xkkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 10:22:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 098AMBuv006624;
        Thu, 8 Oct 2020 10:22:11 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 03:22:11 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
Date:   Thu, 8 Oct 2020 18:22:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007111636.GD3678159@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080077
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/7/20 7:16 PM, Leon Romanovsky wrote:
> On Wed, Oct 07, 2020 at 04:38:45PM +0800, Ka-Cheong Poon wrote:
>> On 10/6/20 8:46 PM, Jason Gunthorpe wrote:
>>> On Tue, Oct 06, 2020 at 05:36:32PM +0800, Ka-Cheong Poon wrote:
>>>
>>>>>>> Kernel modules should not be doing networking unless commanded to by
>>>>>>> userspace.
>>>>>>
>>>>>> It is still not clear why this is an issue with RDMA
>>>>>> connection, but not with general kernel socket.  It is
>>>>>> not random networking.  There is a purpose.
>>>>>
>>>>> It is a problem with sockets too, how do the socket users trigger
>>>>> their socket usages? AFAIK all cases originate with userspace
>>>>
>>>> A user starts a namespace.  The module is loaded for servicing
>>>> requests.  The module starts a listener.  The user deletes
>>>> the namespace.  This scenario will have everything cleaned up
>>>> properly if the listener is a kernel socket.  This is not the
>>>> case with RDMA.
>>>
>>> Please point to reputable code in upstream doing this
>>
>>
>> It is not clear what "reputable" here really means.  If it just
>> means something in kernel, then nearly all, if not all, Internet
>> protocols code in kernel create a control kernel socket for every
>> network namespaces.  That socket is deleted in the per namespace
>> exit function.  If it explicitly means listening socket, AFS and
>> TIPC in kernel do that for every namespaces.  That socket is
>> deleted in the per namespace exit function.
>>
>> It is very common for a network protocol to have something like
>> this for protocol processing.  It is not clear why RDMA subsystem
>> behaves differently and forbids this common practice.  Could you
>> please elaborate the issues this practice has such that the RDMA
>> subsystem cannot support it?
> 
> Just curious, are we talking about theoretical thing here or do you
> have concrete and upstream ULP code to present?


As I mentioned in a previous email, I have running code.
Otherwise, why would I go to such great length to find
out what is missing in the RDMA subsystem in supporting
kernel namespace usage.



-- 
K. Poon
ka-cheong.poon@oracle.com


