Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF77ECE7FD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJGPlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 11:41:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGPlU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 11:41:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97FOhFf123592
        for <linux-rdma@vger.kernel.org>; Mon, 7 Oct 2019 15:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2019-08-05; bh=wDe6WDN2tpCHdPDPzQ1+dVjdfkPEFDMeZpLadoDzLGw=;
 b=S3SVPOHipVFf8R171vxvrMqqx/uKQMnlgX2H79CDtxu7y08zd5Tt0SxxEk0yRrOt9mSF
 TEq44wXP4DRsxyF9P0TMyqdJ7/fY/OYvuXB1cuKdt8TuTrobO/PfTF8rrLWfetjW+WsR
 aYG9c/Pjr5xjzhVdNJUPJPYgqZgJBEoQbEGuX5PE05nKbLIx/cTggtR8m7DPxlJTAX7n
 +YiQ691KeBTMjWTpx78LNegvN7rFiLPwKOupHmhC+f521TJzF6mzlDcA2Am1ChieKa46
 ZTvSZV/S+VuTFBrqkR7Zskpc1KvJDamG6lgCx7R4pVChgAdy5bS3oISNSnPl9x4EU/un YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4q7kjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2019 15:41:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97FOajn044229
        for <linux-rdma@vger.kernel.org>; Mon, 7 Oct 2019 15:41:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vf4n9ft74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2019 15:41:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x97FfHN0005377
        for <linux-rdma@vger.kernel.org>; Mon, 7 Oct 2019 15:41:17 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 08:41:17 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: unregister_device messages at shutdown (v5.4-rc)
Message-Id: <6D3E730A-ED56-4AA9-9BAC-8AD31BB915BB@oracle.com>
Date:   Mon, 7 Oct 2019 11:41:13 -0400
To:     linux-rdma <linux-rdma@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=804
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=886 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070152
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Not quite sure where to report this.

Since v5.4-rc1, at shutdown I'm seeing a hang with this message repeated
in /var/log/messages:

unregister_netdevice: waiting for ens1f0 to become free. Usage count =3D =
1

Google turns up this particular failure off and on for the past few =
years
from various network devices. It's currently 100% reproducible on my =
rig.

ens1f0 is a FastLinq NIC in iWARP mode:

01:00.0 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series =
10/25/40/50GbE Controller (rev 02)
        Subsystem: QLogic Corp. FastLinQ QL41212H 25GbE Adapter

3: ens1f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 9216 qdisc mq state =
DOWN group default qlen 1000
    link/ether f4:e9:d4:72:49:f2 brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.51/24 brd 192.168.100.255 scope global ens1f0
       valid_lft forever preferred_lft forever

(the network switch is powered off at the moment).


--
Chuck Lever



