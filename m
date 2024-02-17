Return-Path: <linux-rdma+bounces-1038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B8859019
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Feb 2024 15:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971681C213F2
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Feb 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0C7B3E6;
	Sat, 17 Feb 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="WpZmyxjT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FE1D543;
	Sat, 17 Feb 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180187; cv=none; b=nrflKFH0fyFJUOVzGZjeRC6AVbaqiXw/lUU/FRxlh7Nsrfwk4JXNVqjNLxLJBBnO8hUbQSEzLFWRcK41AJavSvGEzvnpwQ/VIpfwSYuFNnFZ2pEtj8oIYrosrYay7+/NGod3g68dZRc6d5PVo+eVIoja2V9JD9NpizYRXCECU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180187; c=relaxed/simple;
	bh=4F0fSm9sIOKiDH7biZXDlKbDUozKqdCQrjnWq48Lc08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=naNuORt0t5VwQiVUtNHhgkaiLgidlahpaP6r96EkT46TiVNI4XsKuFRFwZB9xa8aEncgfGP9kFPO9175bUTvkEp24rfH+k35MDXE5cXIi2kGKrYA8ypHIXmhwm+1h9JMdF6w2utfpe1jUHJfPvcIbXOo79engvlzFBl0AScXCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=WpZmyxjT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708180173; x=1708784973; i=erick.archer@gmx.com;
	bh=4F0fSm9sIOKiDH7biZXDlKbDUozKqdCQrjnWq48Lc08=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=WpZmyxjTivrnLIEtXxxit+JG39C/PxnLDhCstpqbWtgCrNEtr7XSkSmdVscBoGrz
	 qqC6baqcUAqw2eKIAqkV/r3urfxJ4/BHWT+/UyXI8+2pVvb3Wz/5yeIvi/91i25qt
	 f00y/Gc/VQG9X7eITWAAIi1apKe2pWoUWh6zhYu9GwN+t+A54xwKMioyvdLEYQgx5
	 P9SzD1GBLwuB7usgdgB8gCN3BdIqTbXeWOfzD1kjSpP98BJT2g+IOu1KZr/9RjZI8
	 tfVhWabQi0oUiky4vSc3Mcq1veMPD6TDLTdGp5ZG43+E7el1j4MuYZ2XTkaGWw1K6
	 k++0/pT1ucmyclBUVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M3DNt-1rewC13ntF-003fXa; Sat, 17 Feb 2024 15:29:33 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] RDMA/uverbs: Remove flexible arrays from struct *_filter
Date: Sat, 17 Feb 2024 15:29:13 +0100
Message-Id: <20240217142913.4285-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D0LW3rS6Kb8KHyd05rEBV3fbPyFXaeuY88272CwGQlRgw1uxXDc
 mLMrydIoRL6XLzaQ8Qopl2bbDv1C+/NQj5rcaw59SoIa+EZD/qSPxRaKeR3jCJVGHkJxA4R
 RwG84lfBqUQhiW6hGuVwIsMJ+zH2gy9Q+iO9DoXOBanQ8Xh53mr6s/W38ByrOD6RnWAOrxU
 kfFSCZ6MvQV6fPjQn3wFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9DffPVlSLGk=;szJhT5oGTWDSgGbknu6B4IBc7Ns
 bXc+cuPplQ+V3MsChBld0LJwcNAwRl3mfZGwiKXOVnNzg3qAv6h+401CqL3AfOnMalwjuJ7S7
 snF+kW44mQweFn5dNtP8U7NNFTRSSoIdBwhD0C/6B+HM9c1pTbTJ4fbxx7f9d2XS9ysoDO0PH
 VEs8i+SYEbM+RfyRjcvT94jVQWXeHjfTvKUkCHmEelyeWOgroCNd6EcojO8FvRGXsbRdP8P7G
 T3SSqP0aJTb4Dgowqns7wUsxq02y1yTFTF+TKWDEv5DZPHkqYh0bOTs+M9SigOoCM9A6uyp7t
 1glin7dWdVqYfZzvoXrZjiklFKmUWZIcJAth1WfkidiStpK6cHf5jwUnBsPhI6l16KqBaCvrl
 L2p5Zv040Nz76mUG5ERdhfJtDiwNVAEz+F6YBEorZ2a9cC5uLdbgPtMc6B2/rJpERVK2ENral
 vtQyBBIIAF7yRKamBTlfsNtIdXxQXia7JbVKDW6x5L8Y8k02J0l3/W+PXCg6viRA9eSQ12z8t
 1jFWs2Ku90pREVVO8RmDLLG5G9INhy9Z/hI6nHHmXNyg4fiwpbsJx1PgbCKpCzSOaKSWvQ5bI
 RywFIX7ht+WO9EwdvkrADyBSPVBdXSXrcBZaWqrtOYCdBp/fgJoc7yv3sdReqtkBdQa8434sO
 wc4ccjVQYeGMiAK4/AyqbuY4gX7SHTLJMZoZ5DmdRAJYItKxBBCZGxRFyrA0tfDXuztY+dPWr
 H8CNWmtHbQV9thpQHvI810ogcRM6aLKMs8AUSRXAxZHPoQwC6RpbLUWBH9b/Dl5rfdLewp0fX
 SfTgOIXd+rjDa8cMYguxlcrLQlvlG6eXQPnLEajheO9gc=

When a struct containing a flexible array is included in another struct,
and there is a member after the struct-with-flex-array, there is a
possibility of memory overlap. These cases must be audited [1]. See:

struct inner {
	...
	int flex[];
};

struct outer {
	...
	struct inner header;
	int overlap;
	...
};

This is the scenario for all the "struct *_filter" structures that are
included in the following "struct ib_flow_spec_*" structures:

struct ib_flow_spec_eth
struct ib_flow_spec_ib
struct ib_flow_spec_ipv4
struct ib_flow_spec_ipv6
struct ib_flow_spec_tcp_udp
struct ib_flow_spec_tunnel
struct ib_flow_spec_esp
struct ib_flow_spec_gre
struct ib_flow_spec_mpls

The pattern is like the one shown below:

struct *_filter {
	...
	u8 real_sz[];
};

struct ib_flow_spec_* {
	...
	struct *_filter val;
	struct *_filter mask;
};

In this case, the trailing flexible array "real_sz" is never allocated
and is only used to calculate the size of the structures. Here the use
of the "offsetof" helper can be changed by the "sizeof" operator because
the goal is to get the size of these structures. Therefore, the trailing
flexible arrays can also be removed.

However, due to the trailing padding that can be induced in structs it
is possible that the:

offsetof(struct *_filter, real_sz) !=3D sizeof(struct *_filter)

This situation happens with the "struct ib_flow_ipv6_filter" and to
avoid it the "__packed" macro is used in this structure. But now, the
"sizeof(struct ib_flow_ipv6_filter)" has changed. This is not a problem
since this size is not used in the code.

The situation now is that "sizeof(struct ib_flow_spec_ipv6)" has also
changed (this struct contains the struct ib_flow_ipv6_filter). This is
also not a problem since it is only used to set the size of the "union
ib_flow_spec", which can store all the "ib_flow_spec_*" structures.

Link: https://github.com/KSPP/linux/issues/202 [1]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Add the "__packed" macro to the "struct ib_flow_ipv6_filter".
- Update the commit message to explain why the "__packed" macro is used.

Previous versions:
v1: https://lore.kernel.org/linux-hardening/20240211115856.9788-1-erick.ar=
cher@gmx.com/

Hi Kees and Jason,

First of all, thanks for yours explanations and tips. These were used to g=
et
the final patch.

The steps that I have followed to only add the "__packed" macro to the
"struct ib_flow_ipv6_filter" are the followings:

Step 1: Create new "struct *_filter_new" structures based on "struct *_fil=
ter"
        structures but with the trailing flexible arrays removed. Create n=
ew
        "struct ib_flow_spec_*_new" structures based on "struct ib_flow_sp=
ec_*"
        structures but containing the new "struct *_filter_new" structures=
.

        Also add a set of assertions to check all the "offsetof" changes m=
ade
        in the patch sent. And a set of assertions to verify if the size o=
f
        all the "struct ib_flow_spec_*" structures " has changed.

 drivers/infiniband/core/uverbs_cmd.c |  19 +++++
 include/rdma/ib_verbs.h              | 117 +++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/cor=
e/uverbs_cmd.c
index 6de05ade2ba9..a7ee65791900 100644
=2D-- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2726,6 +2726,25 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_f=
low_spec_type type,
 	ssize_t actual_filter_sz;
 	ssize_t ib_filter_sz;

+	static_assert(offsetof(struct ib_flow_eth_filter, real_sz) =3D=3D sizeof=
(struct ib_flow_eth_filter_new));
+	static_assert(offsetof(struct ib_flow_ipv4_filter, real_sz) =3D=3D sizeo=
f(struct ib_flow_ipv4_filter_new));
+	static_assert(offsetof(struct ib_flow_ipv6_filter, real_sz) =3D=3D sizeo=
f(struct ib_flow_ipv6_filter_new));
+	static_assert(offsetof(struct ib_flow_tcp_udp_filter, real_sz) =3D=3D si=
zeof(struct ib_flow_tcp_udp_filter_new));
+	static_assert(offsetof(struct ib_flow_tunnel_filter, real_sz) =3D=3D siz=
eof(struct ib_flow_tunnel_filter_new));
+	static_assert(offsetof(struct ib_flow_esp_filter, real_sz) =3D=3D sizeof=
(struct ib_flow_esp_filter_new));
+	static_assert(offsetof(struct ib_flow_gre_filter, real_sz) =3D=3D sizeof=
(struct ib_flow_gre_filter_new));
+	static_assert(offsetof(struct ib_flow_mpls_filter, real_sz) =3D=3D sizeo=
f(struct ib_flow_mpls_filter_new));
+
+	static_assert(sizeof(struct ib_flow_spec_eth) =3D=3D sizeof(struct ib_fl=
ow_spec_eth_new));
+	static_assert(sizeof(struct ib_flow_spec_ib) =3D=3D sizeof(struct ib_flo=
w_spec_ib_new));
+	static_assert(sizeof(struct ib_flow_spec_ipv4) =3D=3D sizeof(struct ib_f=
low_spec_ipv4_new));
+	static_assert(sizeof(struct ib_flow_spec_ipv6) =3D=3D sizeof(struct ib_f=
low_spec_ipv6_new));
+	static_assert(sizeof(struct ib_flow_spec_tcp_udp) =3D=3D sizeof(struct i=
b_flow_spec_tcp_udp_new));
+	static_assert(sizeof(struct ib_flow_spec_tunnel) =3D=3D sizeof(struct ib=
_flow_spec_tunnel_new));
+	static_assert(sizeof(struct ib_flow_spec_esp) =3D=3D sizeof(struct ib_fl=
ow_spec_esp_new));
+	static_assert(sizeof(struct ib_flow_spec_gre) =3D=3D sizeof(struct ib_fl=
ow_spec_gre_new));
+	static_assert(sizeof(struct ib_flow_spec_mpls) =3D=3D sizeof(struct ib_f=
low_spec_mpls_new));
+
 	/* User flow spec size must be aligned to 4 bytes */
 	if (kern_filter_sz !=3D ALIGN(kern_filter_sz, 4))
 		return -EINVAL;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b7b6b58dd348..6ee3110c008e 100644
=2D-- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1914,6 +1914,13 @@ struct ib_flow_eth_filter {
 	u8	real_sz[];
 };

+struct ib_flow_eth_filter_new {
+	u8	dst_mac[6];
+	u8	src_mac[6];
+	__be16	ether_type;
+	__be16	vlan_tag;
+};
+
 struct ib_flow_spec_eth {
 	u32			  type;
 	u16			  size;
@@ -1921,6 +1928,13 @@ struct ib_flow_spec_eth {
 	struct ib_flow_eth_filter mask;
 };

+struct ib_flow_spec_eth_new {
+	u32			      type;
+	u16			      size;
+	struct ib_flow_eth_filter_new val;
+	struct ib_flow_eth_filter_new mask;
+};
+
 struct ib_flow_ib_filter {
 	__be16 dlid;
 	__u8   sl;
@@ -1928,6 +1942,11 @@ struct ib_flow_ib_filter {
 	u8	real_sz[];
 };

+struct ib_flow_ib_filter_new {
+	__be16 dlid;
+	__u8   sl;
+};
+
 struct ib_flow_spec_ib {
 	u32			 type;
 	u16			 size;
@@ -1935,6 +1954,13 @@ struct ib_flow_spec_ib {
 	struct ib_flow_ib_filter mask;
 };

+struct ib_flow_spec_ib_new {
+	u32			     type;
+	u16			     size;
+	struct ib_flow_ib_filter_new val;
+	struct ib_flow_ib_filter_new mask;
+};
+
 /* IPv4 header flags */
 enum ib_ipv4_flags {
 	IB_IPV4_DONT_FRAG =3D 0x2, /* Don't enable packet fragmentation */
@@ -1953,6 +1979,15 @@ struct ib_flow_ipv4_filter {
 	u8	real_sz[];
 };

+struct ib_flow_ipv4_filter_new {
+	__be32	src_ip;
+	__be32	dst_ip;
+	u8	proto;
+	u8	tos;
+	u8	ttl;
+	u8	flags;
+};
+
 struct ib_flow_spec_ipv4 {
 	u32			   type;
 	u16			   size;
@@ -1960,6 +1995,13 @@ struct ib_flow_spec_ipv4 {
 	struct ib_flow_ipv4_filter mask;
 };

+struct ib_flow_spec_ipv4_new {
+	u32			       type;
+	u16			       size;
+	struct ib_flow_ipv4_filter_new val;
+	struct ib_flow_ipv4_filter_new mask;
+};
+
 struct ib_flow_ipv6_filter {
 	u8	src_ip[16];
 	u8	dst_ip[16];
@@ -1971,6 +2013,15 @@ struct ib_flow_ipv6_filter {
 	u8	real_sz[];
 };

+struct ib_flow_ipv6_filter_new {
+	u8	src_ip[16];
+	u8	dst_ip[16];
+	__be32	flow_label;
+	u8	next_hdr;
+	u8	traffic_class;
+	u8	hop_limit;
+};
+
 struct ib_flow_spec_ipv6 {
 	u32			   type;
 	u16			   size;
@@ -1978,6 +2029,13 @@ struct ib_flow_spec_ipv6 {
 	struct ib_flow_ipv6_filter mask;
 };

+struct ib_flow_spec_ipv6_new {
+	u32			       type;
+	u16			       size;
+	struct ib_flow_ipv6_filter_new val;
+	struct ib_flow_ipv6_filter_new mask;
+};
+
 struct ib_flow_tcp_udp_filter {
 	__be16	dst_port;
 	__be16	src_port;
@@ -1985,6 +2043,11 @@ struct ib_flow_tcp_udp_filter {
 	u8	real_sz[];
 };

+struct ib_flow_tcp_udp_filter_new {
+	__be16	dst_port;
+	__be16	src_port;
+};
+
 struct ib_flow_spec_tcp_udp {
 	u32			      type;
 	u16			      size;
@@ -1992,11 +2055,22 @@ struct ib_flow_spec_tcp_udp {
 	struct ib_flow_tcp_udp_filter mask;
 };

+struct ib_flow_spec_tcp_udp_new {
+	u32				  type;
+	u16				  size;
+	struct ib_flow_tcp_udp_filter_new val;
+	struct ib_flow_tcp_udp_filter_new mask;
+};
+
 struct ib_flow_tunnel_filter {
 	__be32	tunnel_id;
 	u8	real_sz[];
 };

+struct ib_flow_tunnel_filter_new {
+	__be32	tunnel_id;
+};
+
 /* ib_flow_spec_tunnel describes the Vxlan tunnel
  * the tunnel_id from val has the vni value
  */
@@ -2007,6 +2081,13 @@ struct ib_flow_spec_tunnel {
 	struct ib_flow_tunnel_filter  mask;
 };

+struct ib_flow_spec_tunnel_new {
+	u32				 type;
+	u16				 size;
+	struct ib_flow_tunnel_filter_new val;
+	struct ib_flow_tunnel_filter_new mask;
+};
+
 struct ib_flow_esp_filter {
 	__be32	spi;
 	__be32  seq;
@@ -2014,6 +2095,11 @@ struct ib_flow_esp_filter {
 	u8	real_sz[];
 };

+struct ib_flow_esp_filter_new {
+	__be32	spi;
+	__be32  seq;
+};
+
 struct ib_flow_spec_esp {
 	u32                           type;
 	u16			      size;
@@ -2021,6 +2107,13 @@ struct ib_flow_spec_esp {
 	struct ib_flow_esp_filter     mask;
 };

+struct ib_flow_spec_esp_new {
+	u32			      type;
+	u16			      size;
+	struct ib_flow_esp_filter_new val;
+	struct ib_flow_esp_filter_new mask;
+};
+
 struct ib_flow_gre_filter {
 	__be16 c_ks_res0_ver;
 	__be16 protocol;
@@ -2029,6 +2122,12 @@ struct ib_flow_gre_filter {
 	u8	real_sz[];
 };

+struct ib_flow_gre_filter_new {
+	__be16 c_ks_res0_ver;
+	__be16 protocol;
+	__be32 key;
+};
+
 struct ib_flow_spec_gre {
 	u32                           type;
 	u16			      size;
@@ -2036,12 +2135,23 @@ struct ib_flow_spec_gre {
 	struct ib_flow_gre_filter     mask;
 };

+struct ib_flow_spec_gre_new {
+	u32			      type;
+	u16			      size;
+	struct ib_flow_gre_filter_new val;
+	struct ib_flow_gre_filter_new mask;
+};
+
 struct ib_flow_mpls_filter {
 	__be32 tag;
 	/* Must be last */
 	u8	real_sz[];
 };

+struct ib_flow_mpls_filter_new {
+	__be32 tag;
+};
+
 struct ib_flow_spec_mpls {
 	u32                           type;
 	u16			      size;
@@ -2049,6 +2159,13 @@ struct ib_flow_spec_mpls {
 	struct ib_flow_mpls_filter     mask;
 };

+struct ib_flow_spec_mpls_new {
+	u32			       type;
+	u16			       size;
+	struct ib_flow_mpls_filter_new val;
+	struct ib_flow_mpls_filter_new mask;
+};
+
 struct ib_flow_spec_action_tag {
 	enum ib_flow_spec_type	      type;
 	u16			      size;

The built of this patch shows an assertion error:

static assertion failed:
drivers/infiniband/core/uverbs_cmd.c:2731:2: note: in expansion of macro =
=E2=80=98static_assert=E2=80=99
 2731 |  static_assert(offsetof(struct ib_flow_ipv6_filter, real_sz) =3D=
=3D sizeof(struct ib_flow_ipv6_filter_new));

Step 2: Add the "__packed" macro to "struct ib_flow_ipv6_filter_new".

 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6ee3110c008e..e10a2bf4e0fe 100644
=2D-- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2020,7 +2020,7 @@ struct ib_flow_ipv6_filter_new {
 	u8	next_hdr;
 	u8	traffic_class;
 	u8	hop_limit;
-};
+} __packed;

 struct ib_flow_spec_ipv6 {
 	u32			   type;

The built of this patch passes the last assertion error but shows a
new error:

static assertion failed:
drivers/infiniband/core/uverbs_cmd.c:2741:2: note: in expansion of macro =
=E2=80=98static_assert=E2=80=99
 2741 |  static_assert(sizeof(struct ib_flow_spec_ipv6) =3D=3D sizeof(stru=
ct ib_flow_spec_ipv6_new));

Step 3: Change the comparison operator in the last assertion.

 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/cor=
e/uverbs_cmd.c
index a7ee65791900..83f9edd55280 100644
=2D-- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2738,7 +2738,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 	static_assert(sizeof(struct ib_flow_spec_eth) =3D=3D sizeof(struct ib_fl=
ow_spec_eth_new));
 	static_assert(sizeof(struct ib_flow_spec_ib) =3D=3D sizeof(struct ib_flo=
w_spec_ib_new));
 	static_assert(sizeof(struct ib_flow_spec_ipv4) =3D=3D sizeof(struct ib_f=
low_spec_ipv4_new));
-	static_assert(sizeof(struct ib_flow_spec_ipv6) =3D=3D sizeof(struct ib_f=
low_spec_ipv6_new));
+	static_assert(sizeof(struct ib_flow_spec_ipv6) !=3D sizeof(struct ib_flo=
w_spec_ipv6_new));
 	static_assert(sizeof(struct ib_flow_spec_tcp_udp) =3D=3D sizeof(struct i=
b_flow_spec_tcp_udp_new));
 	static_assert(sizeof(struct ib_flow_spec_tunnel) =3D=3D sizeof(struct ib=
_flow_spec_tunnel_new));
 	static_assert(sizeof(struct ib_flow_spec_esp) =3D=3D sizeof(struct ib_fl=
ow_spec_esp_new));

Finally the built shows no errors. So, removing all the trailing flexible
arrays and adding the "__packed" macro only affects the size of the
"struct ib_flow_spec_ipv6" structure.

As a final point I would like to comment that the binary comparison
produced results that were complicated for me to analyze due to the
difference in the size of the structures.

Regards,
Erick
=2D--
 drivers/infiniband/core/uverbs_cmd.c | 16 ++++++++--------
 include/rdma/ib_verbs.h              | 19 +------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/cor=
e/uverbs_cmd.c
index 6de05ade2ba9..3d3ee3eca983 100644
=2D-- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2737,7 +2737,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,

 	switch (ib_spec->type & ~IB_FLOW_SPEC_INNER) {
 	case IB_FLOW_SPEC_ETH:
-		ib_filter_sz =3D offsetof(struct ib_flow_eth_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_eth_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2748,7 +2748,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->eth.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_IPV4:
-		ib_filter_sz =3D offsetof(struct ib_flow_ipv4_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_ipv4_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2759,7 +2759,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->ipv4.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_IPV6:
-		ib_filter_sz =3D offsetof(struct ib_flow_ipv6_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_ipv6_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2775,7 +2775,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		break;
 	case IB_FLOW_SPEC_TCP:
 	case IB_FLOW_SPEC_UDP:
-		ib_filter_sz =3D offsetof(struct ib_flow_tcp_udp_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_tcp_udp_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2786,7 +2786,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->tcp_udp.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_VXLAN_TUNNEL:
-		ib_filter_sz =3D offsetof(struct ib_flow_tunnel_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_tunnel_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2801,7 +2801,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 			return -EINVAL;
 		break;
 	case IB_FLOW_SPEC_ESP:
-		ib_filter_sz =3D offsetof(struct ib_flow_esp_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_esp_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2812,7 +2812,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->esp.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_GRE:
-		ib_filter_sz =3D offsetof(struct ib_flow_gre_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_gre_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2823,7 +2823,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->gre.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_MPLS:
-		ib_filter_sz =3D offsetof(struct ib_flow_mpls_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_mpls_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b7b6b58dd348..477bf9dd5e71 100644
=2D-- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1910,8 +1910,6 @@ struct ib_flow_eth_filter {
 	u8	src_mac[6];
 	__be16	ether_type;
 	__be16	vlan_tag;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_eth {
@@ -1924,8 +1922,6 @@ struct ib_flow_spec_eth {
 struct ib_flow_ib_filter {
 	__be16 dlid;
 	__u8   sl;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_ib {
@@ -1949,8 +1945,6 @@ struct ib_flow_ipv4_filter {
 	u8	tos;
 	u8	ttl;
 	u8	flags;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_ipv4 {
@@ -1967,9 +1961,7 @@ struct ib_flow_ipv6_filter {
 	u8	next_hdr;
 	u8	traffic_class;
 	u8	hop_limit;
-	/* Must be last */
-	u8	real_sz[];
-};
+} __packed;

 struct ib_flow_spec_ipv6 {
 	u32			   type;
@@ -1981,8 +1973,6 @@ struct ib_flow_spec_ipv6 {
 struct ib_flow_tcp_udp_filter {
 	__be16	dst_port;
 	__be16	src_port;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_tcp_udp {
@@ -1994,7 +1984,6 @@ struct ib_flow_spec_tcp_udp {

 struct ib_flow_tunnel_filter {
 	__be32	tunnel_id;
-	u8	real_sz[];
 };

 /* ib_flow_spec_tunnel describes the Vxlan tunnel
@@ -2010,8 +1999,6 @@ struct ib_flow_spec_tunnel {
 struct ib_flow_esp_filter {
 	__be32	spi;
 	__be32  seq;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_esp {
@@ -2025,8 +2012,6 @@ struct ib_flow_gre_filter {
 	__be16 c_ks_res0_ver;
 	__be16 protocol;
 	__be32 key;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_gre {
@@ -2038,8 +2023,6 @@ struct ib_flow_spec_gre {

 struct ib_flow_mpls_filter {
 	__be32 tag;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_mpls {
=2D-
2.25.1


