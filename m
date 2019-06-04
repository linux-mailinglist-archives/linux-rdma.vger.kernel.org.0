Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3A349C0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfFDOIS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 10:08:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfFDOIS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jun 2019 10:08:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x54DwSTC051853;
        Tue, 4 Jun 2019 14:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=28DfR7suN2aVDj66cDVdbnWef66xqMjoyP59Tu6ePfE=;
 b=W6A9+MIukBKI41VzQyJ+igZ3kItzXryxlWylKnoJNDElL5R6w3dMdm2LvDZiaN1v2+Km
 7sTqPbBN+CKq2aDEZWlHtNrgd2C/Cwq9TWImuoPF/NcbF16jPrpBG6d1QtUxOEAxNH1v
 5Q9Jk5WDKZYpYfOQY9bXzdfgUeF5QdugnUjnkGqZGFgUmUPV+IThFj7hwlWdXzZflZEV
 BFlVTwZdwODhaxPG1hRskSFyAbv5HqmkDAEEXRhLN3lAfJcao6HVz3Ndez4TJze+4x/x
 ZqvwbhwbzYjiobbjxuJzt/+gVqPuGafwt4jSTfuKsSNnXfcaWYovQpvw6cK5+J31Tu3d 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstdadq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 14:07:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x54E7guR185443;
        Tue, 4 Jun 2019 14:07:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhbm5r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 14:07:57 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x54E7vdQ005520;
        Tue, 4 Jun 2019 14:07:57 GMT
Received: from dhcp-10-172-157-227.no.oracle.com (/10.172.157.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 07:07:57 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [rdma-core patch] ibacm: only open InfiniBand port
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190522124528.5688-1-honli@redhat.com>
Date:   Tue, 4 Jun 2019 16:07:55 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <879912FA-8559-4814-9D07-DC438F682A00@oracle.com>
References: <20190522124528.5688-1-honli@redhat.com>
To:     Honggang LI <honli@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906040095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906040094
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Honggang,


Thanks for your commit. Been OOO, so sorry for the delay.

> On 22 May 2019, at 14:45, Honggang Li <honli@redhat.com> wrote:
>=20
> The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
> "provider" was set in the option file, ibacm will failed with

s/failed/fail/

> segment fault.
>=20
> $ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp =
0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
> $ /usr/sbin/ibacm --systemd
> Segmentation fault (core dumped)

Please add a stack trace so others can easily identify this commit as a =
fix if they run into the same bug.

> acm_open_dev function should not open port for IWARP or ROCE devices.

s/open port/open a umad port/
s/IWARP/iWARP/
s/ROCE/RoCE/

>=20
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
> ibacm/src/acm.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
> index a21069d4..944cb820 100644
> --- a/ibacm/src/acm.c
> +++ b/ibacm/src/acm.c
> @@ -2587,7 +2587,7 @@ acm_open_port(struct acmc_port *port, struct =
acmc_device *dev, uint8_t port_num)
>=20
> 	port->mad_agentid =3D umad_register(port->mad_portid,
> 					  IB_MGMT_CLASS_SA, 1, 1, NULL);
> -	if (port->mad_agentid < 0) {
> +	if (port->mad_agentid < 0 && port->mad_portid > 0) {

It is cleaner to handle the error from umad_open_port() in the if-test =
where it is checked for error, i.e., "if (port->mad_portid < 0)". Or in =
other words, why call umad_open_port() when there was an error from =
umad_open_port()?

But is this related to $Subject? To me, this seems to fix a double error =
message. If you agree, please separate this error fix reporting into a =
separate commit.

> 		umad_close_port(port->mad_portid);
> 		acm_log(0, "ERROR - unable to register MAD client\n");
> 	}
> @@ -2600,6 +2600,7 @@ static void acm_open_dev(struct ibv_device =
*ibdev)
> {
> 	struct acmc_device *dev;
> 	struct ibv_device_attr attr;
> +	struct ibv_port_attr port_attr;
> 	struct ibv_context *verbs;
> 	size_t size;
> 	int i, ret;
> @@ -2628,6 +2629,17 @@ static void acm_open_dev(struct ibv_device =
*ibdev)
> 	list_head_init(&dev->prov_dev_context_list);
>=20
> 	for (i =3D 0; i < dev->port_cnt; i++) {
> +		acm_log(1, "%s %d\n", dev->device.verbs->device->name, =
i);

Shouldn't "ibdev->name" suffice instead of =
"dev->device.verbs->device->name" ?

i + 1 (Port numbers starts at one)

> +		ret =3D ibv_query_port(dev->device.verbs, i+1, =
&port_attr);

s/i+1/i + 1/ (we use kernel style)

> +		if (ret) {
> +			acm_log(0, "ERROR - unable to query an RDMA =
port's attributes\n");
> +			return;

a return here is inappropriate. First, you miss to close the device (aka =
goto err1). In addition, the query of the first port could fail, but you =
will not query the next port(s), which may succeed (and be an IB =
link-layer device). So I think a "continue" is the best solution.

> +		}
> +		if (port_attr.link_layer !=3D IBV_LINK_LAYER_INFINIBAND) =
{
> +			acm_log(1, "not an InfiniBand port\n");
> +			return;

ditto, but suppress the list_add() below if no ports are opened.



Thxs, H=C3=A5kon

> +		}
> +
> 		acm_open_port(&dev->port[i], dev, i + 1);
> 	}
>=20
> --=20
> 2.20.1
