Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8133CE8CD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfJGQMx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 12:12:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 12:12:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97Fx2Qg188222;
        Mon, 7 Oct 2019 16:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=FKnHFkw0TbpQj59RzMmT1edlGNKplvkkjRMQO5rlRG4=;
 b=RR5h6B7RCMYsOrj+XlkTgEfnXxxh1BlQR0WVhNzB03W++LOS0U2Q3e6r9ZyXUi4FhZUR
 x4HgCwLdSn0H4C37kRpvTJ37A3V5FUqTq/zXA0EJ9loBxazEn49MsTSwFJOvdEvvOvRB
 uh8bdSSsZQob7RLn3hQFo853O4H6MYEWYINl67S96XkArOaZBXV+Da5mf0bropJRx/So
 go8I4LnenlaAwC+391A0FBrx4xvIiMAHn+Md1da6Rx3mq3wDxeqS7MjpdaEziJ83fr3q
 ssjdibJYDv2D4sIj4yuT/34oKPqCTG0kkxBW84rGA3IYzNmfDAxsHW88TirrYH7ECCeG vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vektr7nnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 16:12:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97FxKB8135248;
        Mon, 7 Oct 2019 16:10:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vf4phtwj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 16:10:49 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x97GAndY022327;
        Mon, 7 Oct 2019 16:10:49 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 09:10:49 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: unregister_device messages at shutdown (v5.4-rc)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7B6ADDB8B@fmsmsx123.amr.corp.intel.com>
Date:   Mon, 7 Oct 2019 12:10:48 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4651DBF9-875D-4E3C-943D-8D884935B241@oracle.com>
References: <6D3E730A-ED56-4AA9-9BAC-8AD31BB915BB@oracle.com>
 <9DD61F30A802C4429A01CA4200E302A7B6ADDB8B@fmsmsx123.amr.corp.intel.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070154
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Oct 7, 2019, at 12:07 PM, Saleem, Shiraz <shiraz.saleem@intel.com> =
wrote:
>=20
>>=20
>> Subject: unregister_device messages at shutdown (v5.4-rc)
>>=20
>> Not quite sure where to report this.
>>=20
>> Since v5.4-rc1, at shutdown I'm seeing a hang with this message =
repeated in
>> /var/log/messages:
>>=20
>> unregister_netdevice: waiting for ens1f0 to become free. Usage count =
=3D 1
>>=20
>> Google turns up this particular failure off and on for the past few =
years from
>> various network devices. It's currently 100% reproducible on my rig.
>>=20
>> ens1f0 is a FastLinq NIC in iWARP mode:
>>=20
>> 01:00.0 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series
>> 10/25/40/50GbE Controller (rev 02)
>>        Subsystem: QLogic Corp. FastLinQ QL41212H 25GbE Adapter
>>=20
>> 3: ens1f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 9216 qdisc mq =
state
>> DOWN group default qlen 1000
>>    link/ether f4:e9:d4:72:49:f2 brd ff:ff:ff:ff:ff:ff
>>    inet 192.168.100.51/24 brd 192.168.100.255 scope global ens1f0
>>       valid_lft forever preferred_lft forever
>>=20
>> (the network switch is powered off at the moment).
>>=20
>=20
> Perhaps you're hitting the issue addressed in this patch.
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=3D=
for-rc&id=3D390d3fdcae2da52755b31aa44fcf19ecb5a2488b

Thank you. I'll watch for that to appear in v5.4-rc.

--
Chuck Lever



