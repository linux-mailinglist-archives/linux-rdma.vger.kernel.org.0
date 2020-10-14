Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF928D751
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgJNAML (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 20:12:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4223 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgJNAMK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 20:12:10 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f86424d0001>; Tue, 13 Oct 2020 17:11:57 -0700
Received: from [172.27.0.178] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Oct
 2020 00:11:58 +0000
Subject: Re: [PATCH 1/1] IB/isert: add module param to set sg_tablesize for IO
 cmd
To:     Sagi Grimberg <sagi@grimberg.me>, <krishna2@chelsio.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <dledford@redhat.com>
CC:     <oren@nvidia.com>, <maxg@mellanox.com>
References: <20201011090608.159333-1-mgurtovoy@nvidia.com>
 <80448269-91b9-7d11-b18d-fc838d72e2ec@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <7505d8da-9fa6-7460-7e3e-a32e0d9261c7@nvidia.com>
Date:   Wed, 14 Oct 2020 03:11:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <80448269-91b9-7d11-b18d-fc838d72e2ec@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602634317; bh=QzkgwWga4FBxPuRVJyIZzStOG8L6N0lvaNxabCCj8l0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=VU1lVov+XMNle4fLKiUdZ0YDr7jGlEnZpABBuEk/IBBxpQGkAWgHjeJU67tbU8a+J
         KTlZDiUa16ndi25NvgKxSgOMtZxyMILLMH1P1jcx4Wt4YVasxDWUSXiy0axMRhBmNy
         7q1/96ys1brJIwP3sUbni/96giNAk4fLAau8Tj0HX6WOQuL32vMeKl2+CmRbJ4txo7
         m9BptrmY3OZLcjloi+s/V1TXQ9/PWCCQYsoKvqB3H7LkGlrwMBwAR3ayco8WDWfpHA
         Tg3qWGM/BQTLgLGBX1hI7YBw3IIjR5JDZjbX+5aFV85MiGXjRrjzDjUABMQdFyO0w9
         jpgHxH2KDR7Ig==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/14/2020 1:21 AM, Sagi Grimberg wrote:
>
>
> On 10/11/20 2:06 AM, Max Gurtovoy wrote:
>> From: Max Gurtovoy <maxg@mellanox.com>
>>
>> Currently, iser target support max IO size of 16MiB by default. For some
>> adapters, allocating this amount of resources might reduce the total
>> number of possible connections that can be created. For those adapters,
>> it's preferred to reduce the max IO size to be able to create more
>> connections. Since there is no handshake procedure for max IO size in
>> iser protocol, set the default max IO size to 1MiB and add a module
>> parameter for enabling the option to control it for suitable adapters.
>>
>> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>
> You can add a "Fixes:" tag to help it get to stable.

But the previous commit is not buggy. It reveals some resource lacking=20
in some HCAs.

I can add it if needed.

>
>> ---
>> =C2=A0 drivers/infiniband/ulp/isert/ib_isert.c | 27 ++++++++++++++++++++=
++++-
>> =C2=A0 drivers/infiniband/ulp/isert/ib_isert.h |=C2=A0 6 ++++++
>> =C2=A0 2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c=20
>> b/drivers/infiniband/ulp/isert/ib_isert.c
>> index 695f701dc43d..5a47f1bbca96 100644
>> --- a/drivers/infiniband/ulp/isert/ib_isert.c
>> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
>> @@ -28,6 +28,18 @@ static int isert_debug_level;
>> =C2=A0 module_param_named(debug_level, isert_debug_level, int, 0644);
>> =C2=A0 MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0=20
>> (default:0)");
>> =C2=A0 +static int isert_sg_tablesize_set(const char *val,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct kernel_param *kp);
>> +static const struct kernel_param_ops sg_tablesize_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .set =3D isert_sg_tablesize_set,
>> +=C2=A0=C2=A0=C2=A0 .get =3D param_get_int,
>> +};
>> +
>> +static int isert_sg_tablesize =3D ISCSI_ISER_SG_TABLESIZE;
>> +module_param_cb(sg_tablesize, &sg_tablesize_ops,=20
>> &isert_sg_tablesize, 0644);
>> +MODULE_PARM_DESC(sg_tablesize,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Number of gather/scat=
ter entries in a single scsi command,=20
>> should >=3D 128 (default: 256, max: 4096)");
>> +
>> =C2=A0 static DEFINE_MUTEX(device_list_mutex);
>> =C2=A0 static LIST_HEAD(device_list);
>> =C2=A0 static struct workqueue_struct *isert_comp_wq;
>> @@ -47,6 +59,19 @@ static void isert_send_done(struct ib_cq *cq,=20
>> struct ib_wc *wc);
>> =C2=A0 static void isert_login_recv_done(struct ib_cq *cq, struct ib_wc =
*wc);
>> =C2=A0 static void isert_login_send_done(struct ib_cq *cq, struct ib_wc =
*wc);
>> =C2=A0 +static int isert_sg_tablesize_set(const char *val, const struct=
=20
>> kernel_param *kp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int n =3D 0, ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D kstrtoint(val, 10, &n);
>> +=C2=A0=C2=A0=C2=A0 if (ret !=3D 0 || n < ISCSI_ISER_MIN_SG_TABLESIZE ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n > ISCSI_ISER_MAX_SG_TABLES=
IZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 return param_set_int(val, kp);
>> +}
>> +
>> +
>> =C2=A0 static inline bool
>> =C2=A0 isert_prot_cmd(struct isert_conn *conn, struct se_cmd *cmd)
>> =C2=A0 {
>> @@ -101,7 +126,7 @@ isert_create_qp(struct isert_conn *isert_conn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr.cap.max_send_wr =3D ISERT_QP_MAX_REQ=
_DTOS + 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr.cap.max_recv_wr =3D ISERT_QP_MAX_REC=
V_DTOS + 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factor =3D rdma_rw_mr_factor(device->ib_d=
evice, cma_id->port_num,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISCSI_ISER_MAX_SG_TABLESIZE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isert_sg_tablesize);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr.cap.max_rdma_ctxs =3D ISCSI_DEF_XMIT=
_CMDS_MAX * factor;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr.cap.max_send_sge =3D device->ib_devi=
ce->attrs.max_send_sge;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr.cap.max_recv_sge =3D 1;
>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.h=20
>> b/drivers/infiniband/ulp/isert/ib_isert.h
>> index 7fee4a65e181..90ef215bf755 100644
>> --- a/drivers/infiniband/ulp/isert/ib_isert.h
>> +++ b/drivers/infiniband/ulp/isert/ib_isert.h
>> @@ -65,6 +65,12 @@
>> =C2=A0=C2=A0 */
>> =C2=A0 #define ISER_RX_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (I=
SCSI_DEF_MAX_RECV_SEG_LEN + 1024)
>> =C2=A0 +/* Default I/O size is 1MB */
>> +#define ISCSI_ISER_SG_TABLESIZE 256
>
> Maybe name it ISCSI_ISER_DEF_SG_TABLESIZE

ok


>
> Otherwise,
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
