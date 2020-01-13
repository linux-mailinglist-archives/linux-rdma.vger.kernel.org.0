Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5858A139A08
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAMTQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 14:16:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgAMTQk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 14:16:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DJDCo8040438;
        Mon, 13 Jan 2020 19:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=j+nonUWYJFk1Vzwjjy0hf7VzlyfS+OofzKgfB2BtZAs=;
 b=OhRwE4on1w8kwTLu16NPWr+EvXOM9ASNGEvQz98MR1HQv8KsLCY7wAlzpW1jCRjdOEvK
 XLic3hEGvI35YUDZo6LYHChrgdl1z9F2xuQfd7uwwP6VN2hZ3teq08nGWFj9K0Sa4E0s
 atMJducqIAtEvg6kTNgHyAuKFtNDF9663cYozppsgxvGttJYp/qb8p3HQaJfKaEv144x
 unlgV3KcHdRTScOe/SU9qJ/JnFYdzXOj56IitE6nDrPiaft4j0dU/7wzlkZ/7Zq+O29o
 Mt0EK0anUhQM8wQrzgBEFTABH5lC0tTecsThemtBQRg6u07SjHj7tZ2ekAMpH13zVP7R 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74s12at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 19:16:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DJEFUQ164977;
        Mon, 13 Jan 2020 19:16:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xfqu521bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 19:16:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DJGSJ5028834;
        Mon, 13 Jan 2020 19:16:28 GMT
Received: from [10.159.240.107] (/10.159.240.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 11:16:28 -0800
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
 <20191120000840.GQ4991@ziepe.ca>
 <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
 <20191219182511.GI17227@ziepe.ca>
 <6da00014-0fd2-c7fc-93ab-7653b23aeb1e@oracle.com>
 <20200113184757.GB9861@ziepe.ca>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <f3210e8d-1783-2d2d-f835-bee9cc0ec3e7@oracle.com>
Date:   Mon, 13 Jan 2020 11:16:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113184757.GB9861@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=850 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130156
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/13/20 10:47 AM, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2020 at 10:35:14AM -0800, Rao Shoaib wrote:
>> On 12/19/19 10:25 AM, Jason Gunthorpe wrote:
>>> On Tue, Dec 17, 2019 at 11:38:52AM -0800, Rao Shoaib wrote:
>>>> Any update on my patch?
>>>>
>>>> If there is some change needed please let me know.
>>> You need to repost it with the comments addressed
>>>
>>> https://patchwork.kernel.org/patch/11250179/
>>>
>>> Jason
>>>
>> Jason,
>>
>> Following is a pointer to the patch that I posted in response to your
>> comments
>>
>> https://www.spinics.net/lists/linux-rdma/msg86241.html
>>
>> I posted this on Nov 18. Can you please take a look and let me know what
>> else has to be done.
> You mean this:
>
> https://www.spinics.net/lists/linux-rdma/msg86333.html
>
> ?
>
> Don't mix the inline size and the # SGEs. They both drive the maximum
> WQE size and all the math should be directly connected.
>
> Jason

Nope. I have just resent the patch. Sorry for the confusion.

Shoaib.

