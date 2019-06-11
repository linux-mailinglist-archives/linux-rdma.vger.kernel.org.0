Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6D3CBAD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 14:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfFKMcP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 08:32:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbfFKMcO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 08:32:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BCSMdo166304;
        Tue, 11 Jun 2019 12:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=s5XRtEENMjirHerqUbSyG93dHIq3JyxnoP+a4ubNUrM=;
 b=ijahAZNX5osXn3EXYBemuuhUZsc9CHeZf6tAw5C5xm7+2+TXLLTJYsZ2wO+jhIPpleX3
 OOmC15LD3oPbYL8/0VeWLGEl1pgbBiMzB0yjkYDEWFs2SaXJ2Hph4dMyHHjybBPctwz5
 sBgEIGASeIrdGhHTqMPhxCx2J4kExb38/96gjIkn3sEtt1pAsH43DUXIuapztaDyXSN7
 haBNf5QQ6075Z4etKPsVluQoVSQAC2hi62vwtgx3880JxlSxk36WOiL1uBeMnS2E2Tcw
 TcGHbXsfEvD6B2T4Ag+TiF4MTiW6Fmm1w4dP0NSCRFg/FBHLwLzhspqhiqzT8uhAR9BI pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2t02hemy4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 12:31:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BCTG8I010777;
        Tue, 11 Jun 2019 12:29:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t024ucen9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 12:29:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BCTX97031475;
        Tue, 11 Jun 2019 12:29:33 GMT
Received: from dhcp-10-172-157-227.no.oracle.com (/10.172.157.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 05:29:33 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [rdma-core ibacm v2] ibacm: only open InfiniBand port
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190610135527.2638-1-honli@redhat.com>
Date:   Tue, 11 Jun 2019 14:29:31 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B507E339-82E7-4ADC-9EBD-3F9AE343E466@oracle.com>
References: <20190610135527.2638-1-honli@redhat.com>
To:     Honggang Li <honli@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 10 Jun 2019, at 15:55, Honggang Li <honli@redhat.com> wrote:
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
> acm_open_dev function should not open an umad port for iWARP or RoCE =
devices.

It is "a umad port" (as suggested), even though the "u" is a vowel, it =
is pronounced as a consonant, hence "a umad port".

> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
> ibacm/src/acm.c | 26 ++++++++++++++++++++++----
> 1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
> index a21069d4..5c8a5d3c 100644
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
> +			acm_log(0, "ERROR - ibv_query_port failed\n");

With the richness below when printing port or ports, may be add the =
value of ret here as well?

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
> +	if (opened_ib_port_cnt > 0) {

or simpler, if (opened_ib_port_cnt) {

> +		list_add(&dev_list, &dev->entry);
> +		acm_log(1, "%d InfiniBand %s opened for %s\n",
> +				opened_ib_port_cnt,
> +				opened_ib_port_cnt =3D=3D 1 ? =
"port":"ports",

Spaces around ":". I am also OK with the literal "port(s)" as well.

Otherwise, LGTM,

Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>


Thxs, H=C3=A5kon


> +				ibdev->name);
> +		return;
> +	}
>=20
> err1:
> 	ibv_close_device(verbs);
> --=20
> 2.20.1
>=20

