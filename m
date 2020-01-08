Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50B21344EF
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAHOZG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 09:25:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHOZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 09:25:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 008ENHb9117831;
        Wed, 8 Jan 2020 14:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=qWlKteoj7Sg5Q2Jn/BBcJmOkHUQ0uxB28fUw87c6TVU=;
 b=caFtjJxEJ99PdogBXD8rJWQgvHXByBAbREqLHyR7eWHe5yssIGFpH24q3O/rSPqNnL1Y
 EsP24KWSlKfQya86J7oNQaziM6GyMZFh/geJ9C0WDxKTy/sIjDMmYbfl9SRd5Vitt+Wq
 JR8DIFZYgduMB3dQ05vZJHC1GIT0QWfdVLfXDWfHEHTrmUyATeoajAP9VKiyNna0XKfE
 EwOkOCjmKP3YeMM4KAUf3VIvDtxLOPzTJH2aNCos501ERa5ud3de0nBNquaCaU/TRMLU
 lmaSTcylJttnCVwI2FTOQYNkb4qsgkvKwq9RA4Qvt74Leb++Ve/8Z1bJrmQY4ut4VvTj BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xakbqv3gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 14:25:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 008EOMlY051881;
        Wed, 8 Jan 2020 14:24:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xcqbnya51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 14:24:50 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 008ENw3b001185;
        Wed, 8 Jan 2020 14:23:58 GMT
Received: from dhcp-10-172-157-155.no.oracle.com (/10.172.157.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 06:23:58 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH RDMA/uverbs] RDMA/uverbs: Protect list_empty() by lock
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200107184238.GA7928@ziepe.ca>
Date:   Wed, 8 Jan 2020 15:23:55 +0100
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC6982F9-6AED-4EE7-9CF9-AB7564F27E88@oracle.com>
References: <20200106122711.217198-1-haakon.bugge@oracle.com>
 <20200107184238.GA7928@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 7 Jan 2020, at 19:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Mon, Jan 06, 2020 at 01:27:11PM +0100, H=C3=A5kon Bugge wrote:
>> In ib_uverbs_event_read(), events are waited for, then pulled off the
>> kernel's event queue, and finally returned to user space.
>>=20
>> There is an explicit check to see if the device is gone, and if so =
and
>> the there are no events pending, an -EIO is returned.
>>=20
>> However, said test does not check for queue empty whilst holding the
>> lock, so there is a race where the existing code perceives the queue
>> to be empty, when it in fact isn't. Fixed by acquiring the lock ahead
>> of the list_empty() test.
>>=20
>> Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are =
active user space applications")
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> ---
>> drivers/infiniband/core/uverbs_main.c | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/core/uverbs_main.c =
b/drivers/infiniband/core/uverbs_main.c
>> index 970d8e31dd65..7165e51790ed 100644
>> --- a/drivers/infiniband/core/uverbs_main.c
>> +++ b/drivers/infiniband/core/uverbs_main.c
>> @@ -245,12 +245,14 @@ static ssize_t ib_uverbs_event_read(struct =
ib_uverbs_event_queue *ev_queue,
>> 					     =
!uverbs_file->device->ib_dev)))
>> 			return -ERESTARTSYS;
>>=20
>> +		spin_lock_irq(&ev_queue->lock);
>> +
>> 		/* If device was disassociated and no event exists set =
an error */
>> 		if (list_empty(&ev_queue->event_list) &&
>> -		    !uverbs_file->device->ib_dev)
>> +		    !uverbs_file->device->ib_dev) {
>> +			spin_unlock_irq(&ev_queue->lock);
>> 			return -EIO;
>=20
> I noticed this too last month. While this patch is an improvement, I
> had written this one which also fixes the wrong use of devce->ib_dev
> without a READ_ONCE or locking. It is just winding its way through
> testing right now.
>=20
> What do you think?
>=20
> =46rom 37ddee0ea682eaf47e6167a090ae0a4e943f7f68 Mon Sep 17 00:00:00 =
2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Tue, 26 Nov 2019 20:58:04 -0400
> Subject: [PATCH] RDMA/core: Fix locking in ib_uverbs_event_read
>=20
> This should not be using ib_dev to test for disassociation, during
> disassociation is_closed is set under lock and the waitq is triggered.
>=20
> Instead check is_closed and be sure to re-obtain the lock to test the
> value after the wait_event returns.
>=20
> Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are =
active user space applications")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

LGTM,

Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
(or feel free to use my s-o-b, as we coined 80% of this independently of =
each other).


Thxs, H=C3=A5kon


> ---
> drivers/infiniband/core/uverbs_main.c | 24 +++++++++---------------
> 1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/uverbs_main.c =
b/drivers/infiniband/core/uverbs_main.c
> index 953a8c3fae64bd..2b7dc94b6a7a69 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -215,7 +215,6 @@ void ib_uverbs_release_file(struct kref *ref)
> }
>=20
> static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue =
*ev_queue,
> -				    struct ib_uverbs_file *uverbs_file,
> 				    struct file *filp, char __user *buf,
> 				    size_t count, loff_t *pos,
> 				    size_t eventsz)
> @@ -233,19 +232,16 @@ static ssize_t ib_uverbs_event_read(struct =
ib_uverbs_event_queue *ev_queue,
>=20
> 		if (wait_event_interruptible(ev_queue->poll_wait,
> 					     =
(!list_empty(&ev_queue->event_list) ||
> -			/* The barriers built into =
wait_event_interruptible()
> -			 * and wake_up() guarentee this will see the =
null set
> -			 * without using RCU
> -			 */
> -					     =
!uverbs_file->device->ib_dev)))
> +					      ev_queue->is_closed)))
> 			return -ERESTARTSYS;
>=20
> +		spin_lock_irq(&ev_queue->lock);
> +
> 		/* If device was disassociated and no event exists set =
an error */
> -		if (list_empty(&ev_queue->event_list) &&
> -		    !uverbs_file->device->ib_dev)
> +		if (list_empty(&ev_queue->event_list) && =
ev_queue->is_closed) {
> +			spin_unlock_irq(&ev_queue->lock);
> 			return -EIO;
> -
> -		spin_lock_irq(&ev_queue->lock);
> +		}
> 	}
>=20
> 	event =3D list_entry(ev_queue->event_list.next, struct =
ib_uverbs_event, list);
> @@ -280,8 +276,7 @@ static ssize_t ib_uverbs_async_event_read(struct =
file *filp, char __user *buf,
> {
> 	struct ib_uverbs_async_event_file *file =3D filp->private_data;
>=20
> -	return ib_uverbs_event_read(&file->ev_queue, file->uverbs_file, =
filp,
> -				    buf, count, pos,
> +	return ib_uverbs_event_read(&file->ev_queue, filp, buf, count, =
pos,
> 				    sizeof(struct =
ib_uverbs_async_event_desc));
> }
>=20
> @@ -291,9 +286,8 @@ static ssize_t ib_uverbs_comp_event_read(struct =
file *filp, char __user *buf,
> 	struct ib_uverbs_completion_event_file *comp_ev_file =3D
> 		filp->private_data;
>=20
> -	return ib_uverbs_event_read(&comp_ev_file->ev_queue,
> -				    comp_ev_file->uobj.ufile, filp,
> -				    buf, count, pos,
> +	return ib_uverbs_event_read(&comp_ev_file->ev_queue, filp, buf, =
count,
> +				    pos,
> 				    sizeof(struct =
ib_uverbs_comp_event_desc));
> }
>=20
> --=20
> 2.24.1
>=20

