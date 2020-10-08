Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156012872CD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 12:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgJHKtU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 06:49:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48722 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHKtT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 06:49:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098AiDB4073985;
        Thu, 8 Oct 2020 10:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8YjgeqVDcoYVo8MBfzS8OQDS3higTNY1nXe36Tdfbaw=;
 b=pvlPtDR90AUl7sv696EZwjzm7RCqtdGp8qL0dPMzRXMK55rSDMzuxv/6vueRaLQ+TK5D
 Oq7VD1r3S5iipxg6EsOcQhFaM+rlmkU2ctk6uTOqHG3bbsLQgE5dqHCZ89Cgqu8Up/qd
 Hx0fG9punh1tQrlYdoeBgMmRS+8flYh0zzrb3ocbKeHUtwqhKmRJmvolmL5kIZr6xxZh
 ZLU83fFdxPlpgwugyR5ik/AkOTKjSNOrWzdmV8KwV8qzBjN7w17HoviAzKHEb9pgl1Uv
 w6fcsXFIgCcxFbTNzMRf57iTWUokQf50yMLBsIIkEpDxMyH0uoq5GZQdJh1N/wSIxMVx xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33xetb74fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 10:49:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098Al6wP068658;
        Thu, 8 Oct 2020 10:49:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3410k0yn0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 10:49:18 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 098AnHql029440;
        Thu, 8 Oct 2020 10:49:17 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 03:49:17 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
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
 <20201007122830.GM5177@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <83be474c-ac18-ce96-e161-fed86668ffed@oracle.com>
Date:   Thu, 8 Oct 2020 18:49:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007122830.GM5177@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/7/20 8:28 PM, Jason Gunthorpe wrote:
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
> 
> AFS and TIPC are not exactly well reviewed mainstream areas.


How about all the other Internet protocol code?  They all
create a kernel socket without user interaction.  If it is
using rdma_create_id(), it will prevent a namespace from
being deleted.


>> It is very common for a network protocol to have something like
>> this for protocol processing.  It is not clear why RDMA subsystem
>> behaves differently and forbids this common practice.  Could you
>> please elaborate the issues this practice has such that the RDMA
>> subsystem cannot support it?
> 
> The kernel should not have rouge listening sockets just because a
> model is loaded. Creation if listening kernel side sockets should be
> triggered by userspace.


It is unclear why the socket is "rogue".  A sys admin loads a
kernel module for a reason.  It cannot be randomly loaded by
itself.  In this respect, it is not different from a user space
daemon.  No one will describe a listening socket started by a daemon
when it starts as "rogue".  Why is a listening socket started by a
kernel module "rogue"?  If a user is remote, without the listening
socket, how can anything work in the first place?



-- 
K. Poon
ka-cheong.poon@oracle.com


