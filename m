Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4D749C88
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGFMtu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jul 2023 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjGFMtk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jul 2023 08:49:40 -0400
Received: from mailin.dlr.de (mailin.dlr.de [194.94.201.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F56213A
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jul 2023 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dlr.de; i=@dlr.de; q=dns/txt; s=052022;
  t=1688647757; x=1720183757;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=R+6LuiEZYM7M6mldrM97BAO9MvgL7jp+fM6r/3/OsH8=;
  b=Kfm7oH7jUlU3nkFuAc7M65xAe6jWoY7HRTKsO1uWioQgXmxrhK6QFGR9
   Gm7P8aA9oxFWZGJEh4UzeV8MJfhLLKfi+HX32D6XNFAlbBtpEgEh75L+Z
   NfttVa2YgRGPasPKSE+ikxy5fcfapa5csLVvvAMRVr6rIEr2Vvg9y83gC
   /LDMMgJPsPs/W1A1yHduuK8r3TldL+QGNlKoGBQ74RE2J3Fu+nfk4xZej
   0VoOU2OfTgwJgPh7KqKs1wNxxuCRgwogyljipAatvZCW5sY1tr2rt1k6u
   uEfNSnCFXNcIwSIwUCu/niZ3h7Xp2p/6AVhpN686/7mR4fr3C2CxoLlGV
   w==;
X-IPAS-Result: =?us-ascii?q?A2ELAAAzt6Zk/xmKuApaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYMlAoFcG4gGhE6nMoF+DwEBAQEBAQEBAQgBNQ8EAQEEA?=
 =?us-ascii?q?4sUJjQJDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBgUBAoEZhS85DYI3I?=
 =?us-ascii?q?oIELIIXAYEAJgEEG4J3glyoEoE0gQGDGIFesBmBQgGRbYJPig+FdQSJCYQec?=
 =?us-ascii?q?YVdBzKBVIpMZYEnb4EegR56AgkCEWeBCAhfgW8+Ag1UCwtjgRyBGoE0AgIRO?=
 =?us-ascii?q?hRTeBsDBwOBBRAvBwQyJgYJGC8lBlEHLSQJExVBBINYCoELPxUOEYJYIgI9P?=
 =?us-ascii?q?BtNgmoJFw41U4EBEDMEFEgDRB1AAwsHaT01FBsGAgEjgiBuFnVIolaEJV9ll?=
 =?us-ascii?q?C2QUKEfB4IxjVqVDC4XlyOSNi6Xd6gVAgQCBAUCFoFjghZxgzYJSRcCD5kFi?=
 =?us-ascii?q?Qh1OwIHCwEBAwmGSINrgRUBAQ?=
IronPort-PHdr: A9a23:gvoW3xMCGFY9hxtMX9Ul6nbxDRdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6sr1Q6CAN6Tq6odzbaM7ua4AS1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+M
 hS7oR/MusQSjodvKqg8wQbNrndUZuha32xlKUyTkhrm+su84Jtv+DlMtvw88MJNTar1c6MkQ
 LJCET8oKXo15MrltRnCSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRTui9
 aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7WcNUHTmRDQ8lRTTRMDIOiY
 YUSE+oPM+VWr4jhqFUBohSzHhWsBPrtyjNUmnP6wbA23uI8Gg/GxgwgGNcOvWzTodvsMKcdS
 +61wLPNwzXZbvJW2DT955LMchAlu/6BRq9/cc7LyUU1CgzKkEydpIr4NDyayuoDqXKU7/Z8V
 e2xkW4nrRl8rySry8oijoTEmIwYxkzG+Ch5wIg5Od21RU96bNOnDJZcqjyWO5Z1T84mXmxkp
 CY3x7wYtZOlfSUHx5AqywPQZfGBboOG4QrjWf6MLTtknn5pZbGyihmo/US9xODxVdO43EhKo
 yZdj9XBtG4B2wbN5sSaUPdx40Ws1DeV2wzO7OxPPFo6mrDBK5E7x749jp8TsUPeESDogEj2l
 6qWdlk8+uiv9uTnfq3qpp+COI9wjQHzKqoglMqxD+o3MgYAX2+V9+e72rP540H0QLpEgfwon
 6XDsZDaI9gbprSjDANPz4kj7wy/Ay2739sGhXUHLVRFdwybj4XxJl3CPOr0Aeq8jlmjijtn2
 v7LM777DpnTLnXPiLLhcqx8605Yxgoz19df55dMB78YJPL8QEHxuMbdAB8jMg20wuXnB8951
 oMaQ22CGbKWMKfIsVOS++0gPfGAZIkOtznlMfgq++bujWMlmV8aZaSlwIMbaGqkEfR+P0WZf
 X3sj88FEWcLuAo+UePrhESYUTFOYna9Rbkx5i80CI24F4fPXIOtj6Kb3Ce9AJJWYnpKCleWE
 XfnJM24XKJYbCOUP98kiDABXJC/RII7kxKjrgn3z/xgNOWCqQMCspe2gP9x7uOVtgsg9D99C
 8CU+22JVSd4kzVbFHcNwKljrBklmR+42q9ijqkAfeE=
IronPort-Data: A9a23:ShWMpaDOf++CDxVW/5fhw5YqxClBgxIJ4kV8jS/XYbTApD0qgTwCx
 2AfDTvQMv7fMWb0LdtxaYSw8B5S6sPUztFmOVdlrnsFo1CmCCbm6XZ1Cm+qYkt+++WaFBoPA
 /02M4WGdoZuJpPljk/FGqD7qnVh3r2/SLP5CerVUgh8XgYMpB0J0HqPoMZnxNYx6TSFK1nV4
 4iq/JWBYAbNNwNcawr41YrS8HuDg9yv4Fv0jnRmDdhXsVnXkWUiDZ53Dcld+FOhH+G4tsbjL
 wry5OnRElHxpn/BOfv5+lrPSXDmd5aJVeS4Ztu6bID56vRKjnRaPq/Wr5PwY28P49mCt4gZJ
 NmgKfVc4OrmV0HBsL11bvVWL81xFfNc0YDGDCiaiuaS6hTdQ0b30vluAGhjaOX0+s4vaY1P3
 dA8BB0jQDWiotrsnZ+LYa9tgNg5JY/nOJlZtnwIITPxVK5gGMCfBfyRtZkCgV/chegXdRraT
 +0dYDQpTw7SYh5GPlMeIJ46hqGkixETdhUC9wrN/cLb5UDf5RYtzZPXNOP6QYyHH8hMphfJt
 k7ZqjGR7hYycYb3JSC+2natgPLf2Dn3XYs6CrK17LhpjUeVy2hVDwcZPWZXutG1jkKzVdxaK
 kkMoHcjvaN09Uq3VNC7Uxmi5nKJ1vIBZ+dt/yQBwFnl4sLpD8yxXwDokhYphAQaifIL
IronPort-HdrOrdr: A9a23:Ekx4/ai3J/ftv129PM2Egd2aK3BQXg8ji2hC6mlwRA09TyXBrb
 HIoB1p726TtN9xYgBcpTnkAsO9qBznhP1ICOUqUYtKGTOW3FdAT7sSkbcKoQeQeREWn9Q1vc
 wMT0E9MqyUMbEQt6jHCXyDc+rIt+PnzEnHv4jjJjxWPHhXgulbnn9EIzfeKFR/QAQDLpIjfa
 DsmfauZFebCA4qh+qAdwI4Y9Q=
X-Talos-CUID: 9a23:3+SFrGN6sy+93+5DBjNOy085SuUeWHz4lWzgHlSpBWZlYejA
X-Talos-MUID: =?us-ascii?q?9a23=3ASirYSw4+fw6yk3l+zpeDruwXxoxkyr7yFWs3law?=
 =?us-ascii?q?pgJmJbyFpA2bMnBioF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,185,1684792800"; 
   d="scan'208";a="27000"
From:   <Olaf.Krzikalla@dlr.de>
To:     <linux-rdma@vger.kernel.org>
Subject: Understanding the allocation size of mlx5_alloc_buf
Thread-Topic: Understanding the allocation size of mlx5_alloc_buf
Thread-Index: AdmwAiQ5+SoPUCptQLiVJRrCBMG9fw==
Date:   Thu, 6 Jul 2023 12:48:46 +0000
Message-ID: <7f6a9b854205410eb45a665b1e84c0f2@dlr.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi @all,

creating connections via create_qp fails on our cluster for rather small nu=
mbers of processes (128 is working, 256 not) due to an out-of-memory error.=
 I've tracked down the issue to an mlx5_alloc_buf call, which allocates ~50=
0kB per call, which seems to be a lot.

heaptrack tells me the following:

34.47M peak memory consumed over 92 calls from
mlx5_alloc_buf
=A0 in /usr/lib64/libibverbs/libmlx5-rdmav34.so
8.65M consumed over 16 calls from:
=A0 =A0 create_qp
=A0 =A0 =A0 in /usr/lib64/libibverbs/libmlx5-rdmav34.so
=A0 =A0 mlx5_create_qp
=A0 =A0 =A0 in /usr/lib64/libibverbs/libmlx5-rdmav34.so
.

Can anyone help me to understand, what causes a 500kB allocation in create_=
qp? Maybe it is some sort of a configuration issue, which I can handle some=
how.

Thanks for help and best regards
Olaf Krzikalla


System information:
CentOS Linux 7 (Core)
Linux 3.10.0-1160.88.1.el7.x86_64
CA 'mlx5_0'
=A0=A0=A0=A0=A0=A0=A0 CA type: MT4123
=A0=A0=A0=A0=A0=A0=A0 Number of ports: 1
=A0=A0=A0=A0=A0=A0=A0 Firmware version: 20.33.1048
=A0=A0=A0=A0=A0=A0=A0 Hardware version: 0






