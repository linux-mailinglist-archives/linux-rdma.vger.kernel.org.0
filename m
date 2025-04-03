Return-Path: <linux-rdma+bounces-9134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92586A7A07F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 11:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D086173A21
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B1244195;
	Thu,  3 Apr 2025 09:52:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243312E3385;
	Thu,  3 Apr 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673963; cv=none; b=dxgJfu6eGlNE1GuVNnjjsqBL7XXsZhNingiBlWocsRsJEUa6ADsksguqJeowF3uku4AYkLApVzwGsNrUozk6/ut6bc2av8sQQ0u9HUxDg7y96VsJJreZq7FUtSMx/Q9FNaSEk/bjzBfnqRe4sELPNHQT7QSwrNlri+rf6d551eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673963; c=relaxed/simple;
	bh=3yiiA2JhKvLrYXs0WXZvH3KfWbuhniiLUzYYsdf6K0I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZPQ6Cptu2tddExZGQp+0Oqm9fXUBY1ryQhUpz5c5TLUXjCQkgjl9ARQMSf4H2Vpd/6OfyiO0q/Rid4phMKAK/vs9eZ0AIFxUPLVWC7M0EO4BW2uMZWcDwbb+OGF/QlpzoMSiR4WLS7JN7tpiqIFES4CTPvBk79VnO6omsJj/mP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202504031752289983;
        Thu, 03 Apr 2025 17:52:28 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 17:52:27 +0800
Received: from jtjnmail201607.home.langchao.com ([fe80::c5ea:abc2:7a50:1de9])
 by jtjnmail201607.home.langchao.com ([fe80::c5ea:abc2:7a50:1de9%8]) with mapi
 id 15.01.2507.039; Thu, 3 Apr 2025 17:52:27 +0800
From: =?utf-8?B?Q2hhcmxlcyBIYW4o6Z+p5pil6LaFKQ==?= <hanchunchao@inspur.com>
To: "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"markzhang@nvidia.com" <markzhang@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix potential null dereference when enable
 shared FDB
Thread-Topic: [PATCH] net/mlx5: fix potential null dereference when enable
 shared FDB
Thread-Index: AdukfhISoqHM3HXCoEeU3JbpPsETNA==
Date: Thu, 3 Apr 2025 09:52:27 +0000
Message-ID: <526e6240c8964fefa80b4bc759c44c04@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0006_01DBA4C1.28DD0B60"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
tUid: 2025403175228178847127886bb845e3717d21d93ef67
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

------=_NextPart_000_0006_01DBA4C1.28DD0B60
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-ENXIO indicates "No such device or address". I've found that in =
mlx5/core, if mlx5_get_flow_namespace() returns null, it basically =
returns -EOPNOTSUPP.

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Przemek Kitszel =
<przemyslaw.kitszel@intel.com>=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=882=E6=97=A5 =
19:02
=E6=94=B6=E4=BB=B6=E4=BA=BA: Charles Han(=E9=9F=A9=E6=98=A5=E8=B6=85) =
<hanchunchao@inspur.com>
=E6=8A=84=E9=80=81: netdev@vger.kernel.org; linux-rdma@vger.kernel.org; =
linux-kernel@vger.kernel.org; saeedm@nvidia.com; leon@kernel.org; =
tariqt@nvidia.com; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; =
markzhang@nvidia.com; mbloch@nvidia.com
=E4=B8=BB=E9=A2=98: Re: [PATCH] net/mlx5: fix potential null dereference =
when enable shared FDB

On 4/2/25 11:43, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it=20
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
>=20
> Fixes: db202995f503 ("net/mlx5: E-Switch, add logic to enable shared=20
> FDB")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 =
++++++++++
>   drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c       |  5 +++++
>   2 files changed, 15 insertions(+)
>=20
> diff --git=20
> a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c=20
> b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index a6a8eea5980c..dc58e4c2d786 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct =
mlx5_core_dev *master,
>   	if (master) {
>   		ns =3D mlx5_get_flow_namespace(master,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(master, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;

I would return -ENXIO in such cases, you were searching and not found =
that.

IOW it is obvious that dereferencing a null ptr is not supported.

If you agree, please apply the same comment for your other patch:
https://lore.kernel.org/netdev/20250402093221.3253-1-hanchunchao@inspur.c=
om/T/#u

> +		}
> +
>   		root =3D find_root(&ns->node);
>   		mutex_lock(&root->chain_lock);
>   		MLX5_SET(set_flow_table_root_in, in, @@ -2679,6 +2684,11 @@ static =

> int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	} else {
>   		ns =3D mlx5_get_flow_namespace(slave,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root =3D find_root(&ns->node);
>   		mutex_lock(&root->chain_lock);
>   		MLX5_SET(set_flow_table_root_in, in, table_id, diff --git=20
> a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c=20
> b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> index a47c29571f64..18e59f6a0f2d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> @@ -186,6 +186,11 @@ static int mlx5_cmd_set_slave_root_fdb(struct =
mlx5_core_dev *master,
>   	} else {
>   		ns =3D mlx5_get_flow_namespace(slave,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root =3D find_root(&ns->node);
>   		MLX5_SET(set_flow_table_root_in, in, table_id,
>   			 root->root_ft->id);


------=_NextPart_000_0006_01DBA4C1.28DD0B60
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AQUFBwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYI
KoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBT7zLhcTtRnG/DUzvnf
bTyU6LH+GjAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1UdHwSCAQYwggEC
MIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9t
ZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVj
dENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9tZS5sYW5nY2hh
by5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEbMIIBFzCBsQYI
KwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIw
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFv
LERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhv
cml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRF
bnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBJBgNVHREEQjBA
oCYGCisGAQQBgjcUAgOgGAwWaGFuY2h1bmNoYW9AaW5zcHVyLmNvbYEWaGFuY2h1bmNoYW9AaW5z
cHVyLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAMkzghq4SHO2Fi0jhZ+VOCkTi/CTHr498pTYAVLS0
sn5HIh5mWwendN0n32AyOhH6rsbFvddJ0fpH3B86HtXSc20xlnq902GTXbW//53nIGrZ4h/JQvyd
rEd/LXg7eg2MnGwRkF5+4FgA49bazD0rNDgrEWmJxZKw8AKtAbdPwxy1Ht1SnxmzK00VSG2z3SgI
0Jm9SSBrytasx8AtE28UXL3uda2/agWd7LsHcApmqPBkdBxS4WotiWyEJfYbU4KQhdSB+v8utqmB
akOC+gFarxuIilfCjNjh0b9jlTgRo5/vG6kpCUBiy1yiOQ9rTi6NjGzDfVCBJ745tySGx7xZYDGC
A5MwggOPAgEBMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdj
aGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+AAC/VCtcoMk3
ynmeAAAAAL9UMAkGBSsOAwIaBQCgggH4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDQwMzA5NTIyNVowIwYJKoZIhvcNAQkEMRYEFPuUhRywDRP65b+S7JnVjimR
ADAtMH8GCSsGAQQBgjcQBDFyMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixk
ARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+
AAC/VCtcoMk3ynmeAAAAAL9UMIGBBgsqhkiG9w0BCRACCzFyoHAwWTETMBEGCgmSJomT8ixkARkW
A2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAG
A1UEAxMJSU5TUFVSLUNBAhN+AAC/VCtcoMk3ynmeAAAAAL9UMIGTBgkqhkiG9w0BCQ8xgYUwgYIw
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQME
AgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAM4hrLUdN4eh5UgH8Jg8ZV1HomgvIpTi
zXWcgc7A+8MQI4cGUMUNOdXLuS6TfXZY9cJIE4J2hOYimQlXCWXFFiB9HJyeTDNGne0ilDo+Cm9Y
zzkPVCU+g3H+Tu2UDg26urtUhux6h0izVzw4W8GmiPLCBwb2rvfhawj42A891I6bB+VkrteODnOO
7FtbPyskBHlTC/PEBTzfbJKf2Bivts0xre8e1fVHWZNfV8yYpjSvCLbDzWYROrJI0tTtFcssmCkb
8RqahHZbVEkZ3mkn4n3tz0/5dEgRm7sb0IDhr4sYcGrkZ1Lnj6JSMsyuS3zE4wExafhHFUBEYCiE
QsBWvAMAAAAAAAA=

------=_NextPart_000_0006_01DBA4C1.28DD0B60--

