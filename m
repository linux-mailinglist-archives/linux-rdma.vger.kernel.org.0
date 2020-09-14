Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFA268837
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgINJYQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 05:24:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2067 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgINJYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 05:24:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f36af0001>; Mon, 14 Sep 2020 02:23:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 02:24:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Sep 2020 02:24:12 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 09:24:12 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 09:24:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQhJvYnhu2XHDotwWXLOHmfQOUOFWE2FqaeIOIU2oXMwKcCEGtOFI7XffM03175P1hexyRgzQG5rGqNjIcza73yFQS670WBRHk8doV01NSTTa9m+4XxMxwooys0aTOwfaAL4ReOhgLi8CYpOQ1uL/BBJ5hKFYGRcITCQ4bVcJwGwpMdtbTuBmPT8JblnR9w7SPXFGBbgkYYcFY0BscRbROGi7iHNZe3dF0z1zRo/4T9EHb4trVDKsmb6FqqHXr/WI5iaO8FLT+mKFImmMMgyoMoeXIFs2etJ85YISMHa83LshuxcuDSNj6rML6JMBReuv0UosFO2TApMFebC5/qy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47PdbaTHOho6pJnleDNuZbYvhqfNjqNHTWjVmO+FCUU=;
 b=PEZrX54RPJS/m3kTUuC65c/G2Vd0j4mEv2ARe5EasHvgUuFKkKl/2V11vsojOLJlI9LjTXej/JkWFCykZvqXBnqlJwVtqpuXL/1eVf26fFQDIu71hDAqgabAPA9PQjc/FPc4xkC0IYgIeh49vpHRKKk91jKxBxscXpcpOiJ9S7LZFRW6mEVWfTrMlrFuyJFunHOS2BjNXGu/NPzgReGOP/JOKm5IO95xkEjKMdStLAFenrKWcwqHjeFxqJnR6+y9bcooo5U14juuwMtc4vV67psdH+BgTL3ynYcq5lJ5S/FeyL6jjzyJGkTz5A+q18RuhNJW5mzSBHt74oLE6CqVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24)
 by BN8PR12MB2883.namprd12.prod.outlook.com (2603:10b6:408:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 09:24:10 +0000
Received: from BN8PR12MB3220.namprd12.prod.outlook.com
 ([fe80::9d11:73e6:5f3e:e8e3]) by BN8PR12MB3220.namprd12.prod.outlook.com
 ([fe80::9d11:73e6:5f3e:e8e3%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 09:24:10 +0000
From:   Sergey Gorenko <sergeygo@nvidia.com>
To:     "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] srp_daemon: Avoid extra permissions for the lock file
Thread-Topic: [PATCH] srp_daemon: Avoid extra permissions for the lock file
Thread-Index: AQHWdjOe+wgn5hPzo0iAnP+klkdJtaln//CA
Date:   Mon, 14 Sep 2020 09:24:10 +0000
Message-ID: <BN8PR12MB3220065FFCE12DED0704BE9BBF230@BN8PR12MB3220.namprd12.prod.outlook.com>
References: <20200819141745.11005-1-sergeygo@nvidia.com>
In-Reply-To: <20200819141745.11005-1-sergeygo@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [46.219.210.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7af9f042-be68-4bad-1eb6-08d8588ff050
x-ms-traffictypediagnostic: BN8PR12MB2883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2883240BA1F44018F92E8C13BF230@BN8PR12MB2883.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bh0hqGHGlTY5T7HbE00yW+Fm6nM4gHZqLzdDifrgEVekSAmePWngEX7dSXZLUQULZi/H7t5saKKL98D19a6U+yCxJJxIw2gbgzirrBKosuuS9enkwmnqJD84N/SBzSRN2260MrXjSdJSPw2DA5xpnOYkG1z7YPiFbFQ1ns6yBPa0txPJ7ki+iwycyOM4QV5qE6IPhR6eFWUtDL3Qy5nD/NgFepMDA9f+g5YQ3SdPgIemcv+imd7ODPq06C6kIpulbiNiVghyiNlZbtwCFLIfAnvH+mw9n5nCik9UFv5F3jD0DFeGbpUtl5S/bMGheBeoG1PW45+c0fRcz5s3mQlY9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3220.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(76116006)(66946007)(4326008)(6506007)(53546011)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(54906003)(186003)(55236004)(316002)(6916009)(86362001)(107886003)(478600001)(83380400001)(71200400001)(7696005)(52536014)(8676002)(9686003)(55016002)(5660300002)(8936002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xkM1V3Od91QvBOBGfRtthuMZou9O1FaTEwBV0k6dGcPzB+yHIxl+Hib6jYrOhtQmoXLZJnzn4KxQ9GYYKy/K+RPFvYCKwbDdT+tprcm5UqgxFEIoDJB7dpmBsQYCnlJ7arlan2RAiylSAtoNgA5jRtyOIlK4C9qJf44VhX4UoBCqQfw3sj46z1cxRf/4EB3pZBZsRpZoz5SnOokTC+/W9tY3cjVH3y6OZhN/5Qk4Y4IOXgx9P/36fMe4E78W93O2V7PAGsWd5uUlV7eew+sVoHcLWVcwV408PjeNwvr4JFM1MpXyG/pBeDuu+89/CEiNqxPv6+f2NF7cYVDPq3vw0ICN1r+Wi2DxzUkKSQlgFNyMGEf9e/8PdA3GjblGMWNgkYMYe/ZuvP9nqZgb+d+Z18gdrf1XSNr2prj2RLtHHFWhv0edzSyTkVs/J/TuVY+fin8DEdFdUMNrBVfUDzLyQFK5tU73Ei+YrSdGxxRuwd0volaDrdsuE2IaCi1/SC+mnQ44Ti/M+GJW6TQ0jisX6RgfylaXI1c9SI9pvg6AZMGzoHMzCo75Tj6zL6zzLeSdbi0ZsbL9y4KxZgpiq9PgV/YX79C8PEg7IEEO+XqPXq/KEMfjEZ/rrfIpPBGrw6uRqDel4ZpbeolpJDXYTMUWcw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af9f042-be68-4bad-1eb6-08d8588ff050
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 09:24:10.7016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+zFGp64kiySVVIlfZdaRI2bO5YGr++ScTeLB1pA7NX3g67bHFhzJtBeVWntND3WCKpzgM95ygo0U4eic0BTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2883
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600075439; bh=47PdbaTHOho6pJnleDNuZbYvhqfNjqNHTWjVmO+FCUU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=M5ba/6gnjrBCSZSDyGGjZNvS+iBKwCiiKTlTPzjEr9EaffmJqCYic5Rdepks2VnSL
         Cz1rFt7SDvd1sWRFk/wcKTRNFxwjMH8JhI1ccExtPmzj6E2tuhCQqaqAwziDVLhp8R
         d0CWK/NG9HrB3t/Wp3YJkUHSlJv7YBEJ/SUL/4HV7/9bAKrgjPRT7DtcVwtLbdynKa
         Za6or4iogoTZvXwScPTO0mjOZb3Jr0FcSE1gJcKjMZN3dBjJzujoXyJGXcm9I3N+RG
         qysoKK8pSv3ySjGgZsCVOH8z6mrkCPbdQRUx4W9OIV/Zal0LHqVswJlzB+evcHV932
         Ro3AH1FZjQUKQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Sergey Gorenko <sergeygo@nvidia.com>
> Sent: Wednesday, August 19, 2020 5:18 PM
> To: bvanassche@acm.org
> Cc: linux-rdma@vger.kernel.org; Sergey Gorenko <sergeygo@nvidia.com>;
> Max Gurtovoy <mgurtovoy@nvidia.com>
> Subject: [PATCH] srp_daemon: Avoid extra permissions for the lock file
>=20
> There is no need to create a world-writable lock file.
> It's enough to have an RW permission for the file owner only.
>=20
> Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  srp_daemon/srp_daemon.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c index
> f14d9f56c9f2..fcf94537cebb 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -142,7 +142,6 @@ static int check_process_uniqueness(struct config_t
> *conf)
>  		return -1;
>  	}
>=20
> -	fchmod(fd,
> S_IRUSR|S_IRGRP|S_IROTH|S_IWUSR|S_IWGRP|S_IWOTH);
>  	if (0 !=3D lockf(fd, F_TLOCK, 0)) {
>  		pr_err("failed to lock %s (errno: %d). possibly another "
>  		       "srp_daemon is locking it\n", path, errno);
> --
> 2.21.1

Hi Bart,

Could you review the patch? I'm asking for you because you are specified as=
 a maintainer for srp_daemon in rdma-core.

Regards,
Sergey=20
