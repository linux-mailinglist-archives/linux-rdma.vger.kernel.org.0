Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB022C403
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 13:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXLFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 07:05:02 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:43846 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgGXLFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 07:05:01 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OB1s4K026517
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=My9aw5utMkW7KcmdBm/J4lnTT/CbZT+zhEHj9h9ioOQ=;
 b=WtgO4GOsz8SlCJ8IRWfFEzCcK6TCy34a5tdgd70p4hGGfj0A1sOc6d8DhUTGJVeykcW/
 FUm1Xsn/uyIbWLdN0B9FD8sJxg6Ou6xFB+h1eHvTNJWthvcCaOgsYP8xmWnBX3ZgbmFS
 XFWv9tcUHUz13ffimsEKiNxFT/B87An1RZza53ygsxbWi24b9YlvloG1xKtip5N0RKT5
 s97TkWU4iVwnWHUn6Q68TKeoBqJIpRifQKPnly0jJYloLET4BK7nY6YixpvQo7IyX4Qf
 GT0jlPAYXnB/koijEeB6NrgquFsd9HLecCCVKeIL1mAaHhCjwnl/DaqGFuqjC8Wxdu1p 6w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 32bvdkct6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:04:59 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OB2oeJ015836
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:04:58 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0b-00154901.pphosted.com with ESMTP id 32fv89swsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5ASmj26cAZ+xogVv6dBcw/1xTYoIxj9+H3Xelt+ORL6oK9E1CliP4IxVIOuSyr3jKh/DeF3T2MK9c++nSx90nkG6uQAzM7u05WGphDuFkKQzg8xJbuW5azYNq+SCYr4ulvxVKT4/GSeOpGFJFEbOqWQqwiuU5RaZPd71f/3fs0K9atcVpnV/zf8zSuG/lwvc7p08ZErHNeOSmDGsT1NQxi1PqyeGDYvrR7RuXO9WSdl5702VBpAm/aQmOy1VeQ2CKBwLZadCHd17NHw/qcWQzoFopMZUThokqX2D1iDTHz8bhJHGAzJ2aqxhIfa8HA15Ct63oI7yA3GbSIF5S5aaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My9aw5utMkW7KcmdBm/J4lnTT/CbZT+zhEHj9h9ioOQ=;
 b=R/pt1XPYATpKZZoH45gGgG3VomoIFXbrX7x3/yQ3Wyj9S1o7FnxdMLF5ZpjHxumyfWnFkjiADtW67EqMx3lcDw9h021Dfh09EIDtLl4Cv7Ua39QCogyoFQN3V7KhsELVf/5/Hx0a3x0Vpr4j79CUsqqQeq0l+DQVMTlGZaUz8qXXvAfFtDzmNQHzbN32tj82nlU9BtQXWRxPl6QbwU4FNigNbFs1qB5yO4KTAgjiGyL90k6mZBlN3fx1jgQGsN5EzhBfjtQGrbmg0mX0mzx/w8Pj/AIcp3Nzc/Eiy9jLqV+PrVTynxwpRkHL7QvmkhT1/UbQE9d5Rldw5plMZybtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My9aw5utMkW7KcmdBm/J4lnTT/CbZT+zhEHj9h9ioOQ=;
 b=CZ18e50SLwtkIcC4EIMvVatszi7uHFaraMkrxIHjnveAu05Mg3kiCmTM0rVP6ZfRa5zOnGWgLoTD8nbi2ViTpAic5gxuYC8wN1KzMxrT7mdg2wp7Q9giAednUJBOL2EWjjetNthRuTELx1CDmBPu1phaXaGlhhA6k+qHAvVrhsg=
Received: from BN8PR19MB2609.namprd19.prod.outlook.com (2603:10b6:408:6c::29)
 by BN8PR19MB2833.namprd19.prod.outlook.com (2603:10b6:408:8b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 11:04:57 +0000
Received: from BN8PR19MB2609.namprd19.prod.outlook.com
 ([fe80::b45d:2886:59d1:3426]) by BN8PR19MB2609.namprd19.prod.outlook.com
 ([fe80::b45d:2886:59d1:3426%7]) with mapi id 15.20.3195.022; Fri, 24 Jul 2020
 11:04:57 +0000
From:   "Sun, Mingbao" <Tyler.Sun@dell.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Sun, Ao" <Ao.Sun@dell.com>, "Gan, Ping" <Ping.Gan@dell.com>,
        "Zhang, Libin" <Libin.Zhang@dell.com>,
        "Cai, Yanxiu" <Yanxiu.Cai@dell.com>
Subject: [Bug Report] Limitation on number of QPs for single process observed
Thread-Topic: [Bug Report] Limitation on number of QPs for single process
 observed
Thread-Index: AdZhookwO3AY50FtQJSqgeyQzq8r4A==
Date:   Fri, 24 Jul 2020 11:04:57 +0000
Message-ID: <BN8PR19MB260932E68B6399764F79CDA6F5770@BN8PR19MB2609.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Enabled=True;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Owner=Tyler_Sun@dell.com;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_SetDate=2020-07-24T10:57:06.7447403Z;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Name=Customer Communication;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_ActionId=ffd89642-1b1c-42fe-8315-c2bce43f9bb5;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Extended_MSFT_Method=Manual
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [18.162.240.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb42f22-1584-422c-cede-08d82fc166c5
x-ms-traffictypediagnostic: BN8PR19MB2833:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR19MB2833DC4D9E40563AB5DD8D4BF5770@BN8PR19MB2833.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6vndjDJpAKyFulGuPam9QipBzW070PhrHKyEY4qEE1WsB1FeIweCuhqVOLt/TxQAnqq8HJgubTQ1qC4Ypp4JAjR2bukiyiISRon/3w/IdBcK6bD6vnbrLh+wdeo1zzIHHtxKO7cNgk9Q+TeO5QuVRkzOXFOApYh1etqwNLt9xwOMV5xSAvgRIA8xT3z14tn64EheQf6W1XQRDNTU2DtcfmnwV2KJNT86ghTyAua6hZrjwpuoiKBD/St8jtbtAvLyZf50qkYosDcSD0w7P/ReL6Dn+ISZtFsyfKqaZQaz27MUTjj6NSi9KNdHwy6ZcSYRILXd9mbTeMLZZ444d+QmxPvUKQiyQTyKxyYgm9hFpS3ePwhPHIb8GAD0f8SkUX+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB2609.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(52536014)(186003)(2906002)(7696005)(66476007)(66556008)(26005)(66446008)(71200400001)(4326008)(64756008)(83380400001)(6506007)(86362001)(66946007)(478600001)(6916009)(316002)(76116006)(786003)(54906003)(107886003)(8936002)(33656002)(55016002)(5660300002)(8676002)(9686003)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: g2XVAlBc0IVOq5TXWyjAU+6HlekMj1wNNbOC91isf2hNIn78+tmDTZkEMqczZkO+lIkSWuTJnDlEz38i8sRwBBqsu19Uev4EpM9nlpVneUSR0lWEg1rsdM59GvcA/QV1ukq5d2tAgVOrp8c7S9kUK7RTVkt3BNVnflLgjgxIu+0f9Va7X6a+PDXcKwvaDRUr8pB4PF/pxsQGqXHcglXdUSPGkS5CbKDDp4GwOHZR3TEpKr7v7acaORMEvg262hk7sUxfU1kYEm971f1PHlflCcUaNAitHK5yNeU31aSgcPlPfxiBW3QIMSeBm9rOaXbbKqHMhfb0an6NLLjurVOaEAh1WTBoNHp1BIh5T8fa6GXnknZJX0NPudW324j2e4MI7wnLV7tiz7clUvDJRri8NXmKvRH2NU69KptR0VOkej+PSsDAUXlyLch1o9TrywZJJTNezbY/w1h19d2RuVcS1mh5A7BnmDXgoiLbyVezynPuH4VSZw+Y73EKeJonR13u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB2609.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb42f22-1584-422c-cede-08d82fc166c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 11:04:57.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqvGH4s2EItZSqWVlr304FvDaAhEs/cc6jNRENZR6z4igHxI0kEMHnt8cNdXL07n8/nnREk9cCfBnIOK9NbEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR19MB2833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_03:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=925 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240084
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dell Customer Communication - Confidential

Hi,

Information of the Systems:

HOST lehi-dirt (server side)

lehi-dirt:~ # cat /etc/os-release=20
NAME=3D"SLES"
VERSION=3D"12-SP4"
VERSION_ID=3D"12.4"
PRETTY_NAME=3D"SUSE Linux Enterprise Server 12 SP4"
ID=3D"sles"
ANSI_COLOR=3D"0;32"
CPE_NAME=3D"cpe:/o:suse:sles:12:sp4"

lehi-dirt:~ # uname -r
4.12.14-95.48-default

lehi-dirt:~ # ibv_devinfo=20
hca_id: mlx5_bond_0
              transport:                                       InfiniBand (=
0)
              fw_ver:                                            14.26.6000
              node_guid:                                     506b:4b03:00b1=
:7cae
              sys_image_guid:                                          506b=
:4b03:00b1:7cae
              vendor_id:                                      0x02c9
              vendor_part_id:                                          4117
              hw_ver:                                                      =
   0x0
              board_id:                                        DEL281000003=
4
              phys_port_cnt:                              1
              Device ports:
                             port:     1
                                           state:                          =
       PORT_ACTIVE (4)
                                           max_mtu:                        =
 4096 (5)
                                           active_mtu:                     =
 4096 (5)
                                           sm_lid:                         =
     0
                                           port_lid:                       =
     0
                                           port_lmc:                       =
   0x00
                                           link_layer:                     =
   Ethernet

HOST murray-dirt (client side)

murray-dirt:~ # cat /etc/os-release=20
NAME=3D"SLES"
VERSION=3D"12-SP4"
VERSION_ID=3D"12.4"
PRETTY_NAME=3D"SUSE Linux Enterprise Server 12 SP4"
ID=3D"sles"
ANSI_COLOR=3D"0;32"
CPE_NAME=3D"cpe:/o:suse:sles:12:sp4"

murray-dirt:~ # uname -r
4.12.14-95.48-default

murray-dirt:~ # ibv_devinfo=20
hca_id: mlx5_bond_0
              transport:                                       InfiniBand (=
0)
              fw_ver:                                            14.26.6000
              node_guid:                                     506b:4b03:00b1=
:7ca6
              sys_image_guid:                                          506b=
:4b03:00b1:7ca6
              vendor_id:                                      0x02c9
              vendor_part_id:                                          4117
              hw_ver:                                                      =
   0x0
              board_id:                                        DEL281000003=
4
              phys_port_cnt:                              1
              Device ports:
                             port:     1
                                           state:                          =
       PORT_ACTIVE (4)
                                           max_mtu:                        =
 4096 (5)
                                           active_mtu:                     =
 4096 (5)
                                           sm_lid:                         =
     0
                                           port_lid:                       =
     0
                                           port_lmc:                       =
   0x00
                                           link_layer:                     =
   Ethernet

Way to produce the Bug:

              Use a single user-space process as the RDMA client to create =
more than 339 QPs (through API rdma_connect from librdmacm) to a given RDMA=
 server.
              The problem we found is that only 339 QPs could be created.
              During the creation of the 340th QP, the rdma_create_ep retur=
ns fail (Cannot allocate memory) at the client side.



              Following are some of the logs generated by our test tool ib_=
perf.exe:

(1) 1 Server and 1 Client: Client can not create the 340th QP, failed at rd=
ma_create_ep (Cannot allocate memory).


             =20
lehi-dirt:/home/admin/NVMe_OF_test # ib_perf.exe --server-ip 192.168.219.7 =
--server-port 10001 -s --qp-num 1024
qp [0] local 192.168.219.7:10001 peer 192.168.219.8:42196 created.
qp [1] local 192.168.219.7:10001 peer 192.168.219.8:50411 created.
qp [2] local 192.168.219.7:10001 peer 192.168.219.8:44152 created.
......
qp [337] local 192.168.219.7:10001 peer 192.168.219.8:46325 created.
qp [338] local 192.168.219.7:10001 peer 192.168.219.8:60163 created.


             =20
murray-dirt:/home/admin # ib_perf.exe --server-ip 192.168.219.7 --server-po=
rt 10001 -c --qp-num 1024
qp [0] local 192.168.219.8:42196 peer 192.168.219.7:10001 created.
qp [1] local 192.168.219.8:50411 peer 192.168.219.7:10001 created.
qp [2] local 192.168.219.8:44152 peer 192.168.219.7:10001 created.
......
qp [337] local 192.168.219.8:46325 peer 192.168.219.7:10001 created.
qp [338] local 192.168.219.8:60163 peer 192.168.219.7:10001 created.
ERR_DBG:/mnt/linux-dev-framework-master/apps/ib_perf/perf_frmwk.c(599)-crea=
te_connections_client:
rdma_create_ep failed: Cannot allocate memory



(2) 1 Server and 2 Clients:  Server can not create the 340th QP, failed at =
rdma_get_request  (Cannot allocate memory).
And the rdma_create_ep returned success at client side for the 340th QP.

             =20
lehi-dirt:~ # ib_perf.exe --server-ip 192.168.219.7 --server-port 10001 -s =
--qp-num 1024
qp [0] local 192.168.219.7:10001 peer 192.168.219.8:37360 created.
qp [1] local 192.168.219.7:10001 peer 192.168.219.8:35951 created.
......
qp [337] local 192.168.219.7:10001 peer 192.168.219.8:50314 created.
qp [338] local 192.168.219.7:10001 peer 192.168.219.8:42648 created.
ERR_DBG:/mnt/linux-dev-framework-master/apps/ib_perf/perf_frmwk.c(515)-crea=
te_connections_server:
rdma_get_request: Cannot allocate memory

             =20
murray-dirt:/home/admin # ib_perf.exe --server-ip 192.168.219.7 --server-po=
rt 10001 -c --qp-num 200
qp [0] local 192.168.219.8:37360 peer 192.168.219.7:10001 created.
qp [1] local 192.168.219.8:35951 peer 192.168.219.7:10001 created.
......
qp [198] local 192.168.219.8:59660 peer 192.168.219.7:10001 created.
qp [199] local 192.168.219.8:48077 peer 192.168.219.7:10001 created.
200 connection(s) created in total

             =20
murray-dirt:/home/admin # ib_perf.exe --server-ip 192.168.219.7 --server-po=
rt 10001 -c --qp-num 200
qp [0] local 192.168.219.8:45772 peer 192.168.219.7:10001 created.
qp [1] local 192.168.219.8:58067 peer 192.168.219.7:10001 created.
......
qp [137] local 192.168.219.8:50314 peer 192.168.219.7:10001 created.
qp [138] local 192.168.219.8:42648 peer 192.168.219.7:10001 created.
ERR_DBG:/mnt/linux-dev-framework-master/apps/ib_perf/perf_frmwk.c(630)-crea=
te_connections_client:
rdma_connect: Connection refused



(3) NVMe_OF target runs as the server, and 2 ib_perf.exe run as client (eac=
h of them creates 200 QPs): the result is OK.=20

murray-dirt:/home/admin # ib_perf.exe --server-ip 169.254.85.7 --server-por=
t 4420 -c --qp-num 200
qp [0] local 169.254.85.8:53907 peer 169.254.85.7:4420 created.
qp [1] local 169.254.85.8:57988 peer 169.254.85.7:4420 created.
......
qp [198] local 169.254.85.8:58852 peer 169.254.85.7:4420 created.
qp [199] local 169.254.85.8:33436 peer 169.254.85.7:4420 created.
200 connection(s) created in total



murray-dirt:/home/admin # ib_perf.exe --server-ip 169.254.85.7 --server-por=
t 4420 -c --qp-num 200
qp [0] local 169.254.85.8:50105 peer 169.254.85.7:4420 created.
qp [1] local 169.254.85.8:44136 peer 169.254.85.7:4420 created.
......
qp [198] local 169.254.85.8:53581 peer 169.254.85.7:4420 created.
qp [199] local 169.254.85.8:50082 peer 169.254.85.7:4420 created.
200 connection(s) created in total



Thanks,
Tyler=
