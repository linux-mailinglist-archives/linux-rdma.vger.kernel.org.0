Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9436D1E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFFHOb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 03:14:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56952 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHOb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 03:14:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x567E34D139532
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 07:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=F2bghWyT7Io/4Kp5FVYwNf4sygloAp0KRKumRRO9/vk=;
 b=ulkRcX+S0Oehk9xJfar7jrW8kJGBa5seTsH5mSWoUXUiLuqtD+PtC0VseKiyXnCLjGiO
 ec/e8pMTsBDHE7xMUzRgGoqwduWzQ6YAqAlnt4UWV3mONAlP4oF9AzKnnCuj51HofuHT
 doeNNGAQauEml1PoOum40WmQfzwkgORRivPAknHdMSm3L28Xdg+g0po4ycf9p9yH1/ub
 rbMqJbGyfACbuQR2KDi6UroXZ+fMDCIWn+PTlZheSfBAZ6eUWFLH5xvV7cWONHvi+uU/
 v4naggQmrCFsNbvy1ojLMkP0+7GPPJ30ITeYdhWelV4qVedr67gxyqalM3txoGTbmASZ eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2suj0qpjr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 07:14:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x567DBpX163691
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 07:14:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2swngmbtr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 07:14:29 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x567ES3q028807
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 07:14:28 GMT
Received: from dhcp-10-172-157-227.no.oracle.com (/10.172.157.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 00:14:28 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: cma::addr_handler
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <200e4a4b-1151-bcb1-08a8-55e21a393e9c@oracle.com>
Date:   Thu, 6 Jun 2019 09:14:24 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D94AAFD-3023-4721-94F3-B2937F14A4E5@oracle.com>
References: <3B7DEF8D-966E-4C75-9A6D-A55A7B323A4F@oracle.com>
 <200e4a4b-1151-bcb1-08a8-55e21a393e9c@oracle.com>
To:     Yanjun Zhu <yanjun.zhu@oracle.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=772
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=806 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060053
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 6 Jun 2019, at 08:24, Yanjun Zhu <yanjun.zhu@oracle.com> wrote:
>=20
> How to handle "status =3D 0 && id_priv->cma_dev !=3DNULL"?
>=20
> "if (!status && !id_priv->cma_dev)"  is false.
>=20
> "} else if (status) {" is also false.

Exactly, we do not want to print an error message (status !=3D 0) when =
there is no error (status =3D=3D 0).

Thxs, H=C3=A5kon

>=20
> Zhu Yanjun
>=20
> On 2019/6/5 21:40, H=C3=A5kon Bugge wrote:
>> Said function contains:
>>=20
>> 	if (!status && !id_priv->cma_dev) {
>> 		status =3D cma_acquire_dev_by_src_ip(id_priv);
>> 		if (status)
>> 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: =
failed to acquire device. status %d\n",
>> 					     status);
>> 	} else {
>> 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to =
resolve IP. status %d\n", status);
>> 	}
>>=20
>> Now, assuming status =3D=3D 0 and the device already has been =
acquired (id_priv->cma_dev !=3D NULL), we get the "error" message:
>>=20
>> RDMA CM: ADDR_ERROR: failed to resolve IP. status 0
>>=20
>> Probably not intentional.
>>=20
>> So, would we agree to have:
>>=20
>> 	} else if (status) {
>> 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to =
resolve IP. status %d\n", status);
>> 	}
>>=20
>>=20
>> instead?
>>=20
>>=20
>> Thxs, H=C3=A5kon
>>=20
>>=20

