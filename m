Return-Path: <linux-rdma+bounces-1158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D166886A2B7
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 23:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143801F222BA
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579895578D;
	Tue, 27 Feb 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d72kJMjk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="srsxPzzG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA454746;
	Tue, 27 Feb 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073687; cv=fail; b=QFmEChU6WlrLIuHSwkmZFyLmolw/ztMjPjOzvhkvAAiBToDP7cx79rs3lWiqvBJEeE9jb76gJX76t9k7frvruadix/j9L4xWze6MVLQ04D67G761JeygAAPdoBSCDcTE9yeSErw8z61FP6XohBtAqllXq/pmqV6pfL0SfOA+gpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073687; c=relaxed/simple;
	bh=QUkx/3GDogXr03H8Ph/9yKbP48o2+BsOYO7uo/lkyeg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTUoGRoMg7/K0vpgB/h1EduU3oF6z/hlwmgKamArfmcYe+I1fAUuC+3AlhFu2pp/PF29+zrlx2fzHwSPM7H80z3boGYwoaxp9yrKuZGotjgX+jE0bFPlM/A07OpnZVHUMG6zYafqRTknzKxy4NeaaYyKp7tvc0zqY3nv7clgj7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d72kJMjk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=srsxPzzG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKJg49020664;
	Tue, 27 Feb 2024 22:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QUkx/3GDogXr03H8Ph/9yKbP48o2+BsOYO7uo/lkyeg=;
 b=d72kJMjk358jFISCMaGg8xL0yr9OTmsIw32hwKlIwdkRumVb2/n5WBF1Z3SLa/rJy70L
 viy85aeqkqgCm20IaOtYdrr38fEYfEIMdpV5g/X04oLrR19VlCsAcPGHoO3mtrCTPJYq
 IDcYgowUljogZPoYPlMpuO7YVQ7jV0UsW6jhTS2lrqjqu0Jyyfgt3zeV6GIMe0s7Dy4X
 qn/EzIL9NVxtvHV7yD/vSPzEJCq4ET/RyHwrKm282wFBqRLL8tJLiV4urRm8gXWwaloW
 iwhVjw1x1pqe0kGQHeMw9nsw3zzbXorZjiHpRCFqJaTmzRtb1MZBsw0GZDCKS2Hc77Jo VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v8kw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 22:41:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RMDcAw009779;
	Tue, 27 Feb 2024 22:41:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w7yeue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 22:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZtPxaU9nqtVYUMOI0CHJRpxkcYGAzc1UezrPpnUDy3B4FBceCGg+6HsANwT2Rk7f0gFacQg11TtRSOjS5DwaagLDkqEW5WvyhhNxKFf0frMYUy/8wZl6JxIx7rEwuMyqS49RMUWt1tqS+v40iY8ofsy0s61rFqwmEPML1pgAkqxiduG2crujEKfrdrCOpvPs13rXj8pgyA8j1uKGj0A0Xf40XWHPeUPu7imAxaf2IOTzf79TYCMnnYkACFgXkf3MZGSm8XW0jfdqlT697hSwAS2EvhU+su8UKLQA+JA8fGmekEJ7dZA/C9nd8wMWJ/X7vvNvYjsL+WDiQQ7xbYMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUkx/3GDogXr03H8Ph/9yKbP48o2+BsOYO7uo/lkyeg=;
 b=dKCf+8rlELK2WuUY9OPa8AeZEIoSXR6gRpyLdkGC7r7gn/hDWJo/F6LX4nuAx5UTA+FMJJOn5YsWRWDJBjbx5ziRedcMjydRtjbHlaB3yyaEPd/5mpEHm8cBXlChs3DEdMyITqrCF8Ix/4e6cu+90OxorjGTPXGYDwO6E+LwUDsL0EJD8PEzWAdwHzLjrtju+QDr3aTJkgwktuW9sZgB+6gY8nBC4TkSyhujmTF/lhe8OWAFRHiG8ifoPcBX3m6oHs/E9kOIJ7hT4MHjE+QX9MJe2FrJhRdLAI9xGrWgHWOdX5bpe3Y3zJB3P/haJse7SUX8cbPTZilqEPwAf8v3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUkx/3GDogXr03H8Ph/9yKbP48o2+BsOYO7uo/lkyeg=;
 b=srsxPzzGJJ5FafcFGRmyA0BJ9anef784le4lLO8oG3Rk2zp/EfhaYSakVeZI7rLQKVPDNGYJrdoNDFdv8sknfFct6ByuJF9/ls+G1bIt9rB/U+CPN7ZUKzN3P5zFFX4pEqTqfUgp4bUV2bgK/IR+IUcDGMI8apEd6/+XSlR/4Ss=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 22:41:10 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3ebe:ef87:e29d:e6f6]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3ebe:ef87:e29d:e6f6%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 22:41:10 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com"
	<syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh
 Shilimkar <santosh.shilimkar@oracle.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
Thread-Topic: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
Thread-Index: AQHaaY4D3mDVun1rp0axEsB39qJS3rEeyQGA
Date: Tue, 27 Feb 2024 22:41:10 +0000
Message-ID: <bbb62529a1bcee734c1f7e993755e5757f7716ca.camel@oracle.com>
References: <000000000000c0550506125e4118@google.com>
In-Reply-To: <000000000000c0550506125e4118@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DS0PR10MB6847:EE_
x-ms-office365-filtering-correlation-id: 39040919-9cea-4685-5bbd-08dc37e531bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YwNOsHbR/u6qKMzsX/jrdVSKvYIu37bOed3ZjVUhh2sMLbCqz1q1TSdcHqYro9yoXIRZ0KZTpB5TX58gzE7tmvqEo3b/1W1pKH/6YUQc55mnB/P9JwFAPJp7Ndr1uyEUN67e/DumRq4jqj2SoOSgR2fbBFBrh4IwbNTiMghE7wb0nXqLmHaU1LwftMbIJB17cc6QuxAEhzE7kuNDxwZTts927G8I53s7jnggPI4W0OjMLcXXFKvLmmfpNhiPD45ihvb+3U+RJ40vphEm9/GVY+1C+YM4XGXxXZetjvPI96CkzPY+GaDQBn3mpcWGgFjiOaPZ8ZMMnNJjYHsKZaP34vnrZCCrKjNFDjfblDgxVwwstnRmFKUfSG8hIeah7Xo1PAlIzEgjIxnMuNhVzcdybL716GZ7/e//xZ/a7MjxlRCRTjOWTPJoPFWjmr7AJ5CWhcWQU73+C7hLBSfzI0YgFW0ROUioOoW8BOmMJ3dJOdiPx3c51GxCQ+egJ890+RgfTFd3mmj7Tt5XkGOsZxDlXHD3Rm42Htmw1JVBKXal9L58jBQQ2umaSBiHl/f/7AHcT5oDKSHFK44554iK/s40HvwWMIn1DpqVmmdITFIJH8Er0oI3uudPNsDR14PfQuxHTPs2Yl3DPjBqsSONa2b7Ba4HjVqXNbAesxabsBV13aPOb/4wwwnXkdja0SCMQV00Xejqcg6lO/n374MkFWNhdg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UmhUa1drS1A3MUpIZWlNNk1VTG9sSmY0VmpnaCtJdm10Y05DSHE0cEVXODZv?=
 =?utf-8?B?UEpybVplWGFCMTFDaHhROXNSNklDNURtL1krRFlWNE90QitZNVg2dS9wY2Jo?=
 =?utf-8?B?U0djU052L250eEgrTFg3MkV1WVYrL2x1ZzJsejM3THVpQk0vUllHc2ZPRk84?=
 =?utf-8?B?dGJ6U1QvV1M4cm5TbzBQNmM0TGdiUTlzVzlMdDlLYlBoWnpUOVpPYlVFcERE?=
 =?utf-8?B?eUYzSzNWQ0pydVhzaTJ6cTZnTjBXZ0RsT3ZmZExsMi9SdVhuS0wwdS9VK0gw?=
 =?utf-8?B?NVBlY3FOamxtT3pkNzBMUzYzR1NoR3NPR3d2TENQaXJGeWt4L2g2ejRjSHZz?=
 =?utf-8?B?Umt5cGp0bDY0Mnh3U2dJM1BmaDJzV1o3dFI5bk9uYlJidHJ4UjMxZTY1elh6?=
 =?utf-8?B?bEVNaU96cFdndUdqUXRvNjR5LytFbWRWOS9sc2x4VGQ0YWJtM1VxZ1lVcVlU?=
 =?utf-8?B?aytCZi9HTGxCNFpONmJ4SnhqREpuUEdnaHNNMkNmbUFHZmU5UEc4SUNlODRW?=
 =?utf-8?B?UWZEVlV1UUNsSG1sSDJicVhaYUxVSng4S3ZwTEVGa3JISGFUblppUTlNOFVo?=
 =?utf-8?B?b0t4aWhoTjlYeVVZYmhrWVF4RXZNK21LRVNZMFd2WWhNQmM5RlpOZFJOL3FN?=
 =?utf-8?B?Q3RjVy93ZGFVM1cxQXFnemhYZHJ4RWVjOUFUK1ZlMno5bmNNbzU4SC9PaUFX?=
 =?utf-8?B?OTF4cGtQWWRYcGxxaGo3RHg4SitWL0YwSVdLbXM1UVllR0liMzlZRjBkSW9K?=
 =?utf-8?B?TWNmR045MURrSnBlbnR0ZGxpV0RZcVBqV3ZRNXdlTmFuSHZsSnBzRXo2Ylhy?=
 =?utf-8?B?bk1MZEZscWdmNTdSZDhqdksyVTRYMXFaNjdITkhaYVlSdC9qOFdCZmtMdUJx?=
 =?utf-8?B?L1FXMUdXZEpEdHovY1E4Q3l6NzQ4MzZCNWdVMGdGNjlaY00wUlI1NTRBdDFL?=
 =?utf-8?B?ZDJtTW90Y2M1N1ZvTlBIS3lYQUU0RjVnWTBVR3JSV2YxV3dmaTFDMWNFMWVa?=
 =?utf-8?B?Z1lBNDNBbjMwQWt5Wmtwb3lTUkpSdy9FUnBxeGpDSUlGY3JmNkxYN1dHUDdx?=
 =?utf-8?B?U1hERXgwZTk5ZzkvSWxVY3JsVTFVRUhpSVNtSEFRaGFpRkFCKzRyMnpkdWpV?=
 =?utf-8?B?aFBiZ1RQakJnSWlGZ1R1TGozU3VFZVdEaXA2Vkl3Mnd5OVN4YzVHS1BvVTNn?=
 =?utf-8?B?cU9vZjdXVlAyUlc4cDlGR3VrU0d3aWhWSWNuR1RvSnkyN1BOU1RGbkQ0VFFo?=
 =?utf-8?B?eUtxTWo4UmNZbWxlaEswN29uMWMwN3M2R25FWm44aHEwNE50ajlUdi9GWWRG?=
 =?utf-8?B?M1pxUDZWUWZqNXVmQXpUdXhDb0VuN2l0a1pCd21Yam1IcWRPdFF1S3BlcjU1?=
 =?utf-8?B?UTBTZ3lwWFRDZXAwVExwTHZvWnFxY1lNZXFsaU1yL3RZTmlvRDNSNlRDQlA4?=
 =?utf-8?B?NnU2QXkweUNTZHRVbXoxa2NTUDlWenk2OCtNamhzSVhxNWVtNG0vN3hBdEhX?=
 =?utf-8?B?U3hrUW83NC9INHN0QXFjVU10REFsVFFUdXQyRklneGlhSkhMSDRWK2pOK2JT?=
 =?utf-8?B?YThoell0dzZ2VXZRUVVGTEFYSHJpUEZPTFU1WjMvazhWazBQbFVIV2dmZTNE?=
 =?utf-8?B?MDAya0dMS0loQ2I2OE1kV2V1NHN6ZktQNzRjU214dUJOUERiandxZmNCMzd0?=
 =?utf-8?B?cXRDbDE0S1I4eWxkUkJNK3h3anlBS3R3Qk5lVVlVaUUvNlpBWDJLOEtlelIv?=
 =?utf-8?B?U0k1OHhINmVta1J5a04rNEllWEc5bnJ0Sjd1UkQzVFdnK29QS0RyUFhNQlFo?=
 =?utf-8?B?VElqSm9obUQrVTdjVzJDZDkxMzJSQUFwd1FkTVR3bmEwdWduZ3MvTW1TcXFS?=
 =?utf-8?B?QzU4WXNDN0lYK1gvbVFUcW8ra25vWXZxVG0vYVAwb0xNb3ptQlMzVDZmNlU5?=
 =?utf-8?B?MEFObkJPRHg2QXhnTmo5M2RxU1pXSmNsNGxCUmFqb1JaM1hvdjhWUnBWdEl0?=
 =?utf-8?B?MWFJRUlkdjZKaWE3dUthUCttL3JteXlGeVZvK01PZ001UFhvWWY0L0pGZ2lR?=
 =?utf-8?B?ZnAyZHVtUXZLRVU1QmdmNFppYXpYWHJ3YTVHOWdPVjhsWk1wUXVHTk1QQ0g5?=
 =?utf-8?B?bnEzVWNvSnNKa3E1VjFkS0ZEODY4TTJxRkpkK3QzaHdCMHYwcEpUMDFLVzJk?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B78D84388E88684492B10952DA53DD55@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1khfmxL7NtAL1zySWnesLIvtYgQPa6U3qJy7o+Cy4Z0PrbslELyxrOlLqelWhFfDWZpJpwIzypgkVc5wtSJ7XF2EJCeME/caqgCLJBfN5X4ZQjxIb4NBKI8AG4pCbYH57aanDGmH1aLIZa/g6itOjpq5ffT/x7trro6HLkwQ0JJwgI5tmmUINvSaOx54SEvvTWPn10SbhAvR+VnNVNwsJJtkwE02KBN/8/T2Z8fYTIxE7OPq+9mf/03eXgIKnXdK0X/6ziDXsYCZc6tclWJSgyyHLJ9jMS+DcSM5dupOi114qIdN5VitNOW67iQ/Hx++9PvNMe7DOnVsb2iZpaTNnisLxgzUtj/cfz32rrpJha3kRcuN2m21FPtfZFH9ME9bfPwj6bYxvsXCaOqsu7VMUP6vf9Uqm/R4dwZ0fquEuuRcy7eqJWVWWK7wOkcH1o45CkOJqjRVJUA3pOcmBSGqxgx56YNmPzwsYPUEiiZPw3AHQ8wHqD5QzqtPGPOVeZAX+086h9tHgB/Kn69pJAerobpfP6MA9KShTmsDs/YxcAn7cCuIRq0ZUgvj2Snt/BRjEU0nfbPUxfpmoioiPs2pBtZH3LLivMgr8bDBiEAT/54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39040919-9cea-4685-5bbd-08dc37e531bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 22:41:10.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVSHN1dtKUa0JaTbav/gkmvyPU/czHb6185AaOrjpTQfQCCM9GRkMrPPAcS5nzr9xcmFiNdLXlrbE5IklYT42V9bTJeqpPc1Acrktk6IjRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_09,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270175
X-Proofpoint-GUID: KzA4KfHE7Pt0Jdx_YFwQlL4_U-k0YiRH
X-Proofpoint-ORIG-GUID: KzA4KfHE7Pt0Jdx_YFwQlL4_U-k0YiRH

SSdsbCBvcGVuIGFuIGludGVybmFsIGJ1ZyB0byB0cmFjayB0aGlzIG9uZSBhcyB3ZWxsDQoNCk9u
IFR1ZSwgMjAyNC0wMi0yNyBhdCAwNjo1OCAtMDgwMCwgc3l6Ym90IHdyb3RlOg0KPiBzeXpib3Qg
aGFzIGZvdW5kIGEgcmVwcm9kdWNlciBmb3IgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoNCj4gDQo+
IEhFQUQgY29tbWl0OsKgwqDCoCAyNWQ0MzQyNTc0NjQgTWVyZ2UgYnJhbmNoICdwY3MteHBjcy1j
bGVhbnVwcycNCj4gZ2l0IHRyZWU6wqDCoMKgwqDCoMKgIG5ldC1uZXh0DQo+IGNvbnNvbGUrc3Ry
YWNlOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zeXprYWxsZXIuYXBw
c3BvdC5jb20veC9sb2cudHh0P3g9MTFmMDAzNGExODAwMDBfXzshIUFDV1Y1TjlNMlJWOTloUSFJ
cTJXZlBMZ1FBeE5YM1dHUGZaMnZabzhOdkRmMktHREY3d05KSWZXazhGMkhaWXBBZXdpaWtoVEZ1
ekFsLXBXMUdGUzJzQ2NlSEYwb0o1aU5WWXVSclE3VnR5eHNkSTIxekhuUTd5QnRMZWskDQo+IMKg
DQo+IGtlcm5lbCBjb25maWc6wqANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PTU3YzQxZjY0ZjM3ZjUxYzVfXzsh
IUFDV1Y1TjlNMlJWOTloUSFJcTJXZlBMZ1FBeE5YM1dHUGZaMnZabzhOdkRmMktHREY3d05KSWZX
azhGMkhaWXBBZXdpaWtoVEZ1ekFsLXBXMUdGUzJzQ2NlSEYwb0o1aU5WWXVSclE3VnR5eHNkSTIx
ekhuUThJQkl2WVYkDQo+IMKgDQo+IGRhc2hib2FyZCBsaW5rOg0KPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWQ0ZmFl
ZTczMjc1NWJiYTk4MzhlX187ISFBQ1dWNU45TTJSVjk5aFEhSXEyV2ZQTGdRQXhOWDNXR1BmWjJ2
Wm84TnZEZjJLR0RGN3dOSklmV2s4RjJIWllwQWV3aWlraFRGdXpBbC1wVzFHRlMyc0NjZUhGMG9K
NWlOVll1UnJRN1Z0eXhzZEkyMXpIblEzNzNZZGIwJA0KPiDCoA0KPiBjb21waWxlcjrCoMKgwqDC
oMKgwqAgRGViaWFuIGNsYW5nIHZlcnNpb24gMTUuMC42LCBHTlUgbGQgKEdOVSBCaW51dGlscyBm
b3INCj4gRGViaWFuKSAyLjQwDQo+IHN5eiByZXBybzrCoMKgwqDCoMKgDQo+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5
ej94PTExY2JkNzIyMTgwMDAwX187ISFBQ1dWNU45TTJSVjk5aFEhSXEyV2ZQTGdRQXhOWDNXR1Bm
WjJ2Wm84TnZEZjJLR0RGN3dOSklmV2s4RjJIWllwQWV3aWlraFRGdXpBbC1wVzFHRlMyc0NjZUhG
MG9KNWlOVll1UnJRN1Z0eXhzZEkyMXpIblE0WXB1NV9qJA0KPiDCoA0KPiBDIHJlcHJvZHVjZXI6
wqDCoA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zeXprYWxsZXIuYXBw
c3BvdC5jb20veC9yZXByby5jP3g9MTBmZjkzNGExODAwMDBfXzshIUFDV1Y1TjlNMlJWOTloUSFJ
cTJXZlBMZ1FBeE5YM1dHUGZaMnZabzhOdkRmMktHREY3d05KSWZXazhGMkhaWXBBZXdpaWtoVEZ1
ekFsLXBXMUdGUzJzQ2NlSEYwb0o1aU5WWXVSclE3VnR5eHNkSTIxekhuUTBNclA1Z20kDQo+IMKg
DQo+IA0KPiBEb3dubG9hZGFibGUgYXNzZXRzOg0KPiBkaXNrIGltYWdlOg0KPiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1h
c3NldHMvMjczMWFhOWZiMTQzL2Rpc2stMjVkNDM0MjUucmF3Lnh6X187ISFBQ1dWNU45TTJSVjk5
aFEhSXEyV2ZQTGdRQXhOWDNXR1BmWjJ2Wm84TnZEZjJLR0RGN3dOSklmV2s4RjJIWllwQWV3aWlr
aFRGdXpBbC1wVzFHRlMyc0NjZUhGMG9KNWlOVll1UnJRN1Z0eXhzZEkyMXpIblF4bHhXOXMzJA0K
PiDCoA0KPiB2bWxpbnV4Og0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9z
dG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvZDFkYWY1NjYzNTU5L3ZtbGludXgt
MjVkNDM0MjUueHpfXzshIUFDV1Y1TjlNMlJWOTloUSFJcTJXZlBMZ1FBeE5YM1dHUGZaMnZabzhO
dkRmMktHREY3d05KSWZXazhGMkhaWXBBZXdpaWtoVEZ1ekFsLXBXMUdGUzJzQ2NlSEYwb0o1aU5W
WXVSclE3VnR5eHNkSTIxekhuUTdhUmZiWTQkDQo+IMKgDQo+IGtlcm5lbCBpbWFnZToNCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9z
eXpib3QtYXNzZXRzLzc5ODQ0NmU0MTg5Yi9iekltYWdlLTI1ZDQzNDI1Lnh6X187ISFBQ1dWNU45
TTJSVjk5aFEhSXEyV2ZQTGdRQXhOWDNXR1BmWjJ2Wm84TnZEZjJLR0RGN3dOSklmV2s4RjJIWllw
QWV3aWlraFRGdXpBbC1wVzFHRlMyc0NjZUhGMG9KNWlOVll1UnJRN1Z0eXhzZEkyMXpIblE3VzZD
dEFiJA0KPiDCoA0KPiANCj4gSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBpc3N1ZSwgcGxlYXNl
IGFkZCB0aGUgZm9sbG93aW5nIHRhZyB0byB0aGUNCj4gY29tbWl0Og0KPiBSZXBvcnRlZC1ieTog
c3l6Ym90K2Q0ZmFlZTczMjc1NWJiYTk4MzhlQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4g
DQo+IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBXQVJOSU5HOiBDUFU6
IDAgUElEOiA1MjQ0IGF0IG5ldC9yZHMvY29ubmVjdGlvbi5jOjkzMQ0KPiByZHNfY29ubl9jb25u
ZWN0X2lmX2Rvd24rMHg5NS8weGIwIG5ldC9yZHMvY29ubmVjdGlvbi5jOjkzMQ0KPiBNb2R1bGVz
IGxpbmtlZCBpbjoNCj4gQ1BVOiAwIFBJRDogNTI0NCBDb21tOiBzeXotZXhlY3V0b3I0MDMgTm90
IHRhaW50ZWQgNi44LjAtcmM1LQ0KPiBzeXprYWxsZXItMDE1OTItZzI1ZDQzNDI1NzQ2NCAjMA0K
PiBIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21w
dXRlIEVuZ2luZSwNCj4gQklPUyBHb29nbGUgMDEvMjUvMjAyNA0KPiBSSVA6IDAwMTA6cmRzX2Nv
bm5fY29ubmVjdF9pZl9kb3duKzB4OTUvMHhiMCBuZXQvcmRzL2Nvbm5lY3Rpb24uYzo5MzENCj4g
Q29kZTogMDAgNGMgODkgZjAgNDggYzEgZTggMDMgNDIgODAgM2MgMzggMDAgNzQgMDggNGMgODkg
ZjcgZTggMmUgYzMNCj4gNDIgZjcgNDkgOGIgM2UgNWIgNDEgNWUgNDEgNWYgZTkgZjEgZmEgZmYg
ZmYgZTggYWMgNDkgZTAgZjYgOTAgPDBmPg0KPiAwYiA5MCBlYiBjYiA4OSBkOSA4MCBlMSAwNyAz
OCBjMSA3YyBhOSA0OCA4OSBkZiBlOCA3NSBjMiA0MiBmNw0KPiBSU1A6IDAwMTg6ZmZmZmM5MDAw
NDJjZjhhMCBFRkxBR1M6IDAwMDEwMjkzDQo+IFJBWDogZmZmZmZmZmY4YWIzMjNjNCBSQlg6IDAw
MDAwMDAwMDAwMDAwMDIgUkNYOiBmZmZmODg4MDIxMTAwMDAwDQo+IFJEWDogMDAwMDAwMDAwMDAw
MDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDIgUkRJOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFJCUDog
ZmZmZmM5MDAwNDJjZmFkMCBSMDg6IGZmZmZmZmZmOGFiMzIzOGIgUjA5OiBmZmZmZmZmZjhhYjQ0
MzYxDQo+IFIxMDogMDAwMDAwMDAwMDAwMDAwMiBSMTE6IGZmZmY4ODgwMjExMDAwMDAgUjEyOiBm
ZmZmODg4MDc0NmVlMDAwDQo+IFIxMzogZmZmZjg4ODAyZTM5YTZjMCBSMTQ6IGZmZmY4ODgwMjYw
ZjIwMDAgUjE1OiBkZmZmZmMwMDAwMDAwMDAwDQo+IEZTOsKgIDAwMDA3ZjhjODliZmY2YzAoMDAw
MCkgR1M6ZmZmZjg4ODBiOTQwMDAwMCgwMDAwKQ0KPiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+
IENTOsKgIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IENS
MjogMDAwMDAwMDAyMDY5ZDAwMCBDUjM6IDAwMDAwMDAwMjk4OWEwMDAgQ1I0OiAwMDAwMDAwMDAw
MzUwNmYwDQo+IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIy
OiAwMDAwMDAwMDAwMDAwMDAwDQo+IERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAw
ZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IENhbGwgVHJhY2U6DQo+IMKgPFRBU0s+
DQo+IMKgcmRzX3NlbmRtc2crMHgxNDA5LzB4MjI4MCBuZXQvcmRzL3NlbmQuYzoxMzE5DQo+IMKg
c29ja19zZW5kbXNnX25vc2VjIG5ldC9zb2NrZXQuYzo3MzAgW2lubGluZV0NCj4gwqBfX3NvY2tf
c2VuZG1zZysweDIyMS8weDI3MCBuZXQvc29ja2V0LmM6NzQ1DQo+IMKgX19fX3N5c19zZW5kbXNn
KzB4NTI1LzB4N2QwIG5ldC9zb2NrZXQuYzoyNTg0DQo+IMKgX19fc3lzX3NlbmRtc2cgbmV0L3Nv
Y2tldC5jOjI2MzggW2lubGluZV0NCj4gwqBfX3N5c19zZW5kbXNnKzB4MmIwLzB4M2EwIG5ldC9z
b2NrZXQuYzoyNjY3DQo+IMKgZG9fc3lzY2FsbF82NCsweGY5LzB4MjQwDQo+IMKgZW50cnlfU1lT
Q0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NmYvMHg3Nw0KPiBSSVA6IDAwMzM6MHg3ZjhjODljODQ1
MTkNCj4gQ29kZTogMjggMDAgMDAgMDAgNzUgMDUgNDggODMgYzQgMjggYzMgZTggNjEgMWEgMDAg
MDAgOTAgNDggODkgZjggNDgNCj4gODkgZjcgNDggODkgZDYgNDggODkgY2EgNGQgODkgYzIgNGQg
ODkgYzggNGMgOGIgNGMgMjQgMDggMGYgMDUgPDQ4Pg0KPiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBj
MyA0OCBjNyBjMSBiMCBmZiBmZiBmZiBmNyBkOCA2NCA4OSAwMSA0OA0KPiBSU1A6IDAwMmI6MDAw
MDdmOGM4OWJmZjIxOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOg0KPiAwMDAwMDAwMDAwMDAw
MDJlDQo+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZjhjODlkMGU0MjggUkNYOiAw
MDAwN2Y4Yzg5Yzg0NTE5DQo+IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMjAw
MDA4MDAgUkRJOiAwMDAwMDAwMDAwMDAwMDAzDQo+IFJCUDogMDAwMDdmOGM4OWQwZTQyMCBSMDg6
IDAwMDA3ZmZlY2EzYzU3OTcgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFIxMDogMDAwMDAwMDAw
MDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwN2Y4Yzg5ZDBlNDJjDQo+IFIx
MzogMDAwMDdmOGM4OWNkYjRmNCBSMTQ6IDczMmU3OTcyNmY2ZDY1NmQgUjE1OiAwMDAwN2ZmZWNh
M2M1Nzk4DQo+IMKgPC9UQVNLPg0KPiANCj4gDQo+IC0tLQ0KPiBJZiB5b3Ugd2FudCBzeXpib3Qg
dG8gcnVuIHRoZSByZXByb2R1Y2VyLCByZXBseSB3aXRoOg0KPiAjc3l6IHRlc3Q6IGdpdDovL3Jl
cG8vYWRkcmVzcy5naXQgYnJhbmNoLW9yLWNvbW1pdC1oYXNoDQo+IElmIHlvdSBhdHRhY2ggb3Ig
cGFzdGUgYSBnaXQgcGF0Y2gsIHN5emJvdCB3aWxsIGFwcGx5IGl0IGJlZm9yZQ0KPiB0ZXN0aW5n
Lg0KPiANCg0K

