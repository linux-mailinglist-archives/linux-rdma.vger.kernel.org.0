Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C971235D8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2019 20:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLQTj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 14:39:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTj7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Dec 2019 14:39:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHJdRCa141549;
        Tue, 17 Dec 2019 19:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4BOYuh8ulGkl59qgWqeVCwB1Pn9zKhrhGzuQ4x5Zzo0=;
 b=UW/MyzniC+tOP5JQCUjy9b4S2goYhh4DThJU30eJdLwZYzHESG2EJJu5Vaa2V4tCiV/x
 IAPPGONQ5/K3ExCc4KcL2hT1A6gSW8O8WL4g7s6BR/fqghgMhAi2Y85KcxQ2k2m+fstu
 L9WiaAMOV6S4IoNhSBzVFc6As6I05WwB2rkvlDd6bEJ16aM2a13/46a5d2edis2QMuWD
 DHlUd35uy7IA2YQ4anYU79xq5R9OutbKVM41OVZf0pHIEjccZiVSI0ZgOjV0+j+g934s
 dsXIprRPCQ5moKF3o9ZvybjWMVk8UUjlkURD+ywI4EnM7uOGMcOeJnFEIr7IGpGeBu5P 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wvrcr8tu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 19:39:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHJdSni163573;
        Tue, 17 Dec 2019 19:39:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wxm73c5k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 19:39:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBHJcrJv016366;
        Tue, 17 Dec 2019 19:38:54 GMT
Received: from [10.159.228.128] (/10.159.228.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 11:38:53 -0800
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
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
Date:   Tue, 17 Dec 2019 11:38:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120000840.GQ4991@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912170156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912170156
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Any update on my patch?

If there is some change needed please let me know.

Shoaib

On 11/19/19 4:08 PM, Jason Gunthorpe wrote:
> On Tue, Nov 19, 2019 at 03:55:35PM -0800, Rao Shoaib wrote:
>
>> My intent is that we calculate and use the maximum buffer size using the
>> maximum of, number of SGE's and inline data requested, not controlling the
>> size of WQE buffer. If I was trying to limit WQE size I would agree with
>> you. Defining MAX_WQE_SIZE based on MAX_SGE and recalculating MAX_SGE does
>> not make sense to me. MAX_SGE and inline_data are independent variables and
>> define the size of wqe size not the other wise around. I did make
>> inline_dependent on MAX_SGE.
> What you are trying to do is limit the size of the WQE to some maximum
> and from there you can compute the upper limit on the SGE and the
> inline data arrays, depending on how the WQE is being used.
>
> If a limit must be had then the limit is the WQE size. It is also
> reasonable to ask why rxe has a limit at all, or why the limit is so
> small ie why can't it be 2k or something? But that is something else
>
> Jason
