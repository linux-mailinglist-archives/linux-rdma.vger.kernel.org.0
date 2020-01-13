Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434821398FA
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 19:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMSf0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 13:35:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMSf0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 13:35:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DIXPOM176061;
        Mon, 13 Jan 2020 18:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HXDDGSzgg1+VLbzPleiazKwhjMHpugozxt4GTzIIub4=;
 b=r1H9ZG5Dmf5kb31eZYUtsWOTu8ez10SPC+g6EvFgeC6ySZIZvx2pQxla7rVH8rwP8NRL
 3DlVPHzDonOsuE1wJxpxY3cFoThAVogkPPw03dja54AKkbtl556BmB4vR50MieErtHjq
 r8DY75tT+DpOPkfOLOhldRsHggren3gojmramg1NqWAMzbndgPY14FYfk7zcmh2wp9iz
 XtE6raIX6xdR7ZIn8ry0ko7Ng6yVgCO0BFn67yBx2P8zzhbgCyXlD6CXTYj3vnl4vblJ
 +gAmjHA9YOJuwXNUj22Ecuh51nCGrfwLXDANAqBY7cTtjPQlrCW7zrLfnCVmLkxakW3J 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xf73y8sss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 18:35:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DIYNUY171694;
        Mon, 13 Jan 2020 18:35:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xfrgj5yh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 18:35:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DIZG5P005040;
        Mon, 13 Jan 2020 18:35:16 GMT
Received: from [10.159.240.107] (/10.159.240.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 10:35:16 -0800
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
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <6da00014-0fd2-c7fc-93ab-7653b23aeb1e@oracle.com>
Date:   Mon, 13 Jan 2020 10:35:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219182511.GI17227@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=763
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=824 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130150
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/19/19 10:25 AM, Jason Gunthorpe wrote:
> On Tue, Dec 17, 2019 at 11:38:52AM -0800, Rao Shoaib wrote:
>> Any update on my patch?
>>
>> If there is some change needed please let me know.
> You need to repost it with the comments addressed
>
> https://patchwork.kernel.org/patch/11250179/
>
> Jason
>
Jason,

Following is a pointer to the patch that I posted in response to your 
comments

https://www.spinics.net/lists/linux-rdma/msg86241.html

I posted this on Nov 18. Can you please take a look and let me know what 
else has to be done.

Shoaib

