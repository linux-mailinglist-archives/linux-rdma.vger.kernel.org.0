Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25CA25ABBD
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBNHp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 09:07:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59844 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIBNG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 09:06:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082D4A3d103028;
        Wed, 2 Sep 2020 13:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qvwp3yBVwwITv/8+6dlwTjK2ap2gakr/fir2Htw0WIM=;
 b=uGuLh1O4zEYhbufPRW9oOC/jG5IIYZaiCmjdW5TkiwMPw3IH89FYGPclYqdfZPuUXRvz
 qA2BFuHWlIlHaCwlYCpqTRboYv16Q0pQjsJF4XZ/zd090B7EMEvGYl0aJ3J63m4K/wj1
 xd984LQVbyOOI75xfYTp+3C8q/q6vGckhNtaQzO3Q5XhkMUE7wDsIVojATbVv5BlViFH
 j3dBJOb9Ep4xAIkCvyOTp5UZZrGOwRT1nyUncY77qUPnTeQ6yWxB2GvwzF9GpIVuOrli
 1vipvFsp1rO1GZGd1gE7kJehtuX2NfBc8iCciVIL/hA8ilR72zhiWpDK1VETQLEy9twc aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eymac3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 13:06:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082D4do2088713;
        Wed, 2 Sep 2020 13:06:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380x6m6qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 13:06:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082D6htd013745;
        Wed, 2 Sep 2020 13:06:44 GMT
Received: from dhcp-10-175-173-45.vpn.oracle.com (/10.175.173.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 06:06:43 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [rdma:for-next 16/50] drivers/infiniband/hw/mlx4/cm.c:496:48:
 sparse: sparse: incorrect type in initializer (different address spaces)
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200902124017.GS1152540@nvidia.com>
Date:   Wed, 2 Sep 2020 15:06:40 +0200
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CC007B8-FF12-48F6-ABA3-BD2417AF1794@oracle.com>
References: <202009021436.HsjhN4O1%lkp@intel.com>
 <20200902115228.GP1152540@nvidia.com>
 <CC1EC6BF-BAF0-42C2-9DF2-6E233B702119@oracle.com>
 <20200902124017.GS1152540@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 2 Sep 2020, at 14:40, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Wed, Sep 02, 2020 at 02:18:27PM +0200, H=C3=A5kon Bugge wrote:
>>=20
>>=20
>>> On 2 Sep 2020, at 13:52, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>=20
>>> On Wed, Sep 02, 2020 at 02:01:41PM +0800, kernel test robot wrote:
>>>> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
>>>> head:   524d8ffd07f0ca10b24011487339f836ed859b32
>>>> commit: 227a0e142e375909959a74b7782403e14331f6f3 [16/50] IB/mlx4: =
Add support for REJ due to timeout
>>>> config: i386-randconfig-s001-20200902 (attached as .config)
>>>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>>> reproduce:
>>>>       # apt-get install sparse
>>>>       # sparse version: v0.6.2-191-g10164920-dirty
>>>>       git checkout 227a0e142e375909959a74b7782403e14331f6f3
>>>>       # save the attached .config to linux build tree
>>>>       make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix =
-D__CHECK_ENDIAN__' ARCH=3Di386=20
>>>>=20
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>=20
>>> Gah!
>>>=20
>>> H=C3=A5kon, radix trees are not allowed please change this to =
xarray!
>>=20
>> I believe this is lack of __rcu in the variable definition. I started =
with
>>=20
>> 	void **slot;=20
>>=20
>> but sparse didn't like it, so I changed it to:
>>=20
>> 	__rcu void **slot;
>>=20
>> sparse liked that, but then it didn't like:
>>=20
>> 	struct rej_tmout_entry *item =3D *slot;
>>=20
>> Shall I change that to:
>>=20
>> 	struct rej_tmout_entry *item =3D =
rcu_dereference_protected(*slot, true);
>>=20
>> ?
>>=20
>>=20
>> Not sure why I need to meld in this rcu stuff when everything is =
protected by a mutex anyway.
>>=20
>> Please advice,
>=20
> Change to xarray.

Understood. It has to be converted anyway, now is probably the best =
time.


Thxs, H=C3=A5kon

>=20
> Jason

