Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6D43C58
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFMPfV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:35:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37322 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfFMK02 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 06:26:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DADtuq179758;
        Thu, 13 Jun 2019 10:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=j1PtYE1zOHH9hfkOKIl3egKVJgazzXij8h70vplFa/E=;
 b=UdAqVv58Y3mOhqKwRk8KjFSDtaCw8hxy4yDTrwP5I3cMPMJ8U/C34j4pIxRmF6BngcIx
 bA8qPcRW3fsCY/ENQ7v2RQYfj3Zw0Z2R42o9WK0mZuzeynyUdDzUsZgHScXBZ8xfm13/
 n0d5k3pukQI0FA03HQAWwAehxqzqPXHttfBG5vqF5iD3LLjrbB7AiipcfZ2x3bJI5PkF
 /rvVx2h4noA775X/UPgqHe7Iceqj59J5ggJe47684V5ILwCQFH5JKV6xdWyQb5nBkFOF
 3/VEc9PB87QqkIrzKOg0aT4UNzX8AbepH5HjA9HrTuEcy1iPGbnyPe9TK5HgIPrW3Y3i mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04eu0q68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:26:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DAOE37082957;
        Thu, 13 Jun 2019 10:26:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t0p9sayhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:26:05 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DAQ5IN009506;
        Thu, 13 Jun 2019 10:26:05 GMT
Received: from dhcp-10-172-157-227.no.oracle.com (/10.172.157.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 03:26:05 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [rdma-core ibacm v3] ibacm: only open InfiniBand port
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190611233325.3141-1-honli@redhat.com>
Date:   Thu, 13 Jun 2019 12:26:01 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6024E50-C005-464B-A670-034B3F98AEA7@oracle.com>
References: <20190611233325.3141-1-honli@redhat.com>
To:     Honggang Li <honli@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130081
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 12 Jun 2019, at 01:33, Honggang Li <honli@redhat.com> wrote:
>=20
> The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
> "provider" was set in the option file, ibacm will fail with
> segment fault.
>=20
> $ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp =
0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
> $ /usr/sbin/ibacm --systemd
> Segmentation fault (core dumped)
> $ gdb /usr/sbin/ibacm core.ibacm
> (gdb) bt
> 0  0x00005625a4809217 in acm_assign_provider (port=3D0x5625a4bc6f28) =
at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2285
> 1  acm_port_up (port=3D0x5625a4bc6f28) at =
/usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2372
> 2  0x00005625a48073d2 in acm_activate_devices () at =
/usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2564
> 3  main (argc=3D<optimized out>, argv=3D<optimized out>) at =
/usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:3270
>=20
> Note: The rpm was built with tarball generated from upstream repo. The =
last
> commit is aa41a65ec86bdb9c1c86e57885ee588b39558238.
>=20
> acm_open_dev function should not open a umad port for iWARP or RoCE =
devices.
> Signed-off-by: Honggang Li <honli@redhat.com>

Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>


Thxs, H=C3=A5kon

> ---
> ibacm/src/acm.c | 26 ++++++++++++++++++++++----
> 1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
> index a21069d4..ad313075 100644
> --- a/ibacm/src/acm.c
> +++ b/ibacm/src/acm.c
> @@ -2600,9 +2600,11 @@ static void acm_open_dev(struct ibv_device =
*ibdev)
> {
> 	struct acmc_device *dev;
> 	struct ibv_device_attr attr;
> +	struct ibv_port_attr port_attr;
> 	struct ibv_context *verbs;
> 	size_t size;
> 	int i, ret;
> +	unsigned int opened_ib_port_cnt =3D 0;
>=20
> 	acm_log(1, "%s\n", ibdev->name);
> 	verbs =3D ibv_open_device(ibdev);
> @@ -2628,13 +2630,29 @@ static void acm_open_dev(struct ibv_device =
*ibdev)
> 	list_head_init(&dev->prov_dev_context_list);
>=20
> 	for (i =3D 0; i < dev->port_cnt; i++) {
> +		acm_log(1, "%s port %d\n", ibdev->name, i + 1);
> +		ret =3D ibv_query_port(dev->device.verbs, i + 1, =
&port_attr);
> +		if (ret) {
> +			acm_log(0, "ERROR - ibv_query_port (%d)\n", =
ret);
> +			continue;
> +		}
> +		if (port_attr.link_layer !=3D IBV_LINK_LAYER_INFINIBAND) =
{
> +			acm_log(1, "not an InfiniBand port\n");
> +			continue;
> +		}
> +
> 		acm_open_port(&dev->port[i], dev, i + 1);
> +		opened_ib_port_cnt++;
> 	}
>=20
> -	list_add(&dev_list, &dev->entry);
> -
> -	acm_log(1, "%s opened\n", ibdev->name);
> -	return;
> +	if (opened_ib_port_cnt) {
> +		list_add(&dev_list, &dev->entry);
> +		acm_log(1, "%d InfiniBand %s opened for %s\n",
> +				opened_ib_port_cnt,
> +				opened_ib_port_cnt =3D=3D 1 ? "port" : =
"ports",
> +				ibdev->name);
> +		return;
> +	}
>=20
> err1:
> 	ibv_close_device(verbs);
> --=20
> 2.20.1
>=20

