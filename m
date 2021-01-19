Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1B2FBAAD
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbhASPAh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 10:00:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390587AbhASOpz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 09:45:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JEeH7T034622;
        Tue, 19 Jan 2021 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Xs7XcSPuXtCAy9E1BtGD/cICdsavHCcacyUpBLbq1A4=;
 b=BusxizjtMEoqCd/hKEzruaZv+e0k/XUtX9OAhGd/PhGbFJkCpPGdHYNyk3PYqshrCRLV
 nY7BHY9jJ/SZtYM7oTiXDyxTtg3NYP6fLV6oucSThg5v3QUupYbUpkmumpDLj+ppJz1A
 neH6nKXvevoUCwuebAcQl2wZxGf+dla0Kp0WK7YeqrfOlW6UWbzS/hhxYB7eAJTICmq6
 MuOgx0chYu4up2VlSywtXZLCXIfeNApQ9Apy5smeHq0AOUd87M5d9xi8UPH38+OjMVTS
 ss1ujty/wyK2ifAjwA3X9YdbynKy5ZhxukL22R/XwfD5ATlt5Jd43aI2aW3M6jAK++iV 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 363r3ksa9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 14:44:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JEi9CL102060;
        Tue, 19 Jan 2021 14:44:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3649wrnk6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 14:44:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10JEbmaA001956;
        Tue, 19 Jan 2021 14:37:49 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 06:37:48 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
Date:   Tue, 19 Jan 2021 09:37:47 -0500
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
        Christoph Hellwig <hch@lst.de>, murphyt7@tcd.ie
Content-Transfer-Encoding: quoted-printable
Message-Id: <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
 <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190089
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 18, 2021, at 8:22 PM, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>=20
> Do you mind posting the cap and ecap of the iommu used by your device?
>=20
> You can get it via sysfs, for example:
>=20
> /sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
> address  cap  domains_supported  domains_used  ecap  version

[root@manet intel-iommu]# lspci | grep Mellanox
03:00.0 Network controller: Mellanox Technologies MT27520 Family =
[ConnectX-3 Pro]
[root@manet intel-iommu]# pwd
/sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/iommu/intel-iommu
[root@manet intel-iommu]# for i in *; do   echo -n $i ": ";   cat $i; =
done
address : c7ffc000
cap : d2078c106f0466
domains_supported : 65536
domains_used : 62
ecap : f020de
version : 1:0
[root@manet intel-iommu]#


>> Fwiw, this system uses the Intel C612 chipset with Intel(R) Xeon(R)
>> E5-2603 v3 @ 1.60GHz CPUs.
>=20
> Can you please also hack a line of code to check the return value of
> iommu_dma_map_sg()?

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
index baca49fe83af..e811562ead0e 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -328,6 +328,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt =
*r_xprt,
=20
        dma_nents =3D ib_dma_map_sg(ep->re_id->device, mr->mr_sg, =
mr->mr_nents,
                                  mr->mr_dir);
+       trace_printk("ib_dma_map_sg(%d) returns %d\n", mr->mr_nents, =
dma_nents);
        if (!dma_nents)
                goto out_dmamap_err;
        mr->mr_device =3D ep->re_id->device;

During the 256KB iozone test I used before, this trace log is generated:

   kworker/u28:3-1269  [000]   336.054743: bprint:               =
frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.054835: bprint:               =
frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.055022: bprint:               =
frwr_map: ib_dma_map_sg(4) returns 1
   kworker/u28:3-1269  [000]   336.055118: bprint:               =
frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.055312: bprint:               =
frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.055407: bprint:               =
frwr_map: ib_dma_map_sg(4) returns 1

--
Chuck Lever



