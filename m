Return-Path: <linux-rdma+bounces-6825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77DA01D64
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 03:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7743A40F8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84831482F2;
	Mon,  6 Jan 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="El8uUMlG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3A8635E;
	Mon,  6 Jan 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130166; cv=none; b=XCD944eB/18VPH03ci1UL/5frV53ajw6qLxi42N4J37ll9RwkwxeZ03+ZsWGpIzTUl9wZtra2WwgdmOoN4SuPW6DDTUW5lYkfA08AAoQs/rwgA5yx5OxhVOjetLF2XiIEhzJtmfktYp4bhE32bZll0OTehF2gqEPa2hh/I98LPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130166; c=relaxed/simple;
	bh=dZVOpEst/qspKVunrqu6CpIBSf8oznN+U6QQp8YJh00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P13gAsLD+Nx+PIWx/HmhtkOyK/DasDb9yoWPkYgT+2VofN289aSQHpjJVZGn5NyumX02AG6qDPKm+Vr5Vc3PoCqmq2HYQ8OJi9SWuEn+YJ8stRL6ephhqgPlyGGGCpX9zNHcDLtAf3uQCOZWLs+/g7CXI42I8+0QToiOROOqJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=El8uUMlG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736130155; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yocnAk5mmlwMtlys+e25C5zWX+pUv49psFpo3P+QH0c=;
	b=El8uUMlGOSRxdps/tkgFHQpKxPS87i4CHqMr/kX2IyvK3D0qWoc8eO/9n+sJij8xZu9rdjTk65/wSMYFujN3DyIvYt3y2bhKLEzuJQl6ghmn7S5N08/CyMy1w6Evyq3efhFgSxtUfM5vU0xRz6a5D64j0s5AQRhlm+pvPWk1nUc=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WMzlXZF_1736130153 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 10:22:34 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 5/5] bpf/selftests: add selftest for bpf_smc_ops
Date: Mon,  6 Jan 2025 10:22:22 +0800
Message-ID: <20250106022222.80203-6-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250106022222.80203-1-alibuda@linux.alibaba.com>
References: <20250106022222.80203-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests introduces a tiny smc_ops for filtering SMC connections based on
IP pairs, and also adds a realistic topology model to verify this ops.

Also, we can only use SMC loopback under CI test, so an
additional configuration needs to be enabled.

Follow the steps below to run this test.

make -C tools/testing/selftests/bpf
cd tools/testing/selftests/bpf
sudo ./test_progs -t smc

Results shows:
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 390 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 116 ++++++
 3 files changed, 510 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..e1479d28136d 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -113,3 +113,7 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_INFINIBAND=y
+CONFIG_SMC=Y
+CONFIG_SMC_OPS=y
+CONFIG_SMC_LO=y
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
new file mode 100644
index 000000000000..689ac13fb6ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <linux/genetlink.h>
+#include "network_helpers.h"
+#include "bpf_smc.skel.h"
+
+#ifndef IPPROTO_SMC
+#define IPPROTO_SMC 256
+#endif
+
+#define CLIENT_IP			"127.0.0.1"
+#define SERVER_IP			"127.0.1.0"
+#define SERVER_IP_VIA_RISK_PATH	"127.0.2.0"
+
+#define SERVICE_1	11234
+#define SERVICE_2	22345
+#define SERVICE_3	33456
+
+#define TEST_NS	"bpf_smc_netns"
+
+enum {
+	SMC_NETLINK_ADD_UEID = 10,
+	SMC_NETLINK_REMOVE_UEID
+};
+
+enum {
+	SMC_NLA_EID_TABLE_UNSPEC,
+	SMC_NLA_EID_TABLE_ENTRY,    /* string */
+};
+
+struct smc_strat_ip_key {
+	__u32  sip;
+	__u32  dip;
+};
+
+struct smc_strat_ip_value {
+	__u8	mode;
+};
+
+struct msgtemplate {
+	struct nlmsghdr n;
+	struct genlmsghdr g;
+	char buf[1024];
+};
+
+#define GENLMSG_DATA(glh)	((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
+#define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
+#define NLA_DATA(na)		((void *)((char *)(na) + NLA_HDRLEN))
+#define NLA_PAYLOAD(len)	((len) - NLA_HDRLEN)
+
+#define MAX_MSG_SIZE		1024
+
+#define SMC_GENL_FAMILY_NAME	"SMC_GEN_NETLINK"
+#define SMC_BPFTEST_UEID	"SMC-BPFTEST-UEID"
+
+static uint16_t smc_nl_family_id = -1;
+static struct nstoken *nstoken;
+
+static int send_cmd(int fd, __u16 nlmsg_type, __u32 nlmsg_pid, __u16 nlmsg_flags,
+			__u8 genl_cmd, __u16 nla_type,
+			void *nla_data, int nla_len)
+{
+	struct nlattr *na;
+	struct sockaddr_nl nladdr;
+	int r, buflen;
+	char *buf;
+
+	struct msgtemplate msg = {0};
+
+	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	msg.n.nlmsg_type = nlmsg_type;
+	msg.n.nlmsg_flags = nlmsg_flags;
+	msg.n.nlmsg_seq = 0;
+	msg.n.nlmsg_pid = nlmsg_pid;
+	msg.g.cmd = genl_cmd;
+	msg.g.version = 1;
+	na = (struct nlattr *) GENLMSG_DATA(&msg);
+	na->nla_type = nla_type;
+	na->nla_len = nla_len + 1 + NLA_HDRLEN;
+	memcpy(NLA_DATA(na), nla_data, nla_len);
+	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
+
+	buf = (char *) &msg;
+	buflen = msg.n.nlmsg_len;
+	memset(&nladdr, 0, sizeof(nladdr));
+	nladdr.nl_family = AF_NETLINK;
+
+	while ((r = sendto(fd, buf, buflen, 0, (struct sockaddr *) &nladdr,
+			   sizeof(nladdr))) < buflen) {
+		if (r > 0) {
+			buf += r;
+			buflen -= r;
+		} else if (errno != EAGAIN)
+			return -1;
+		}
+	return 0;
+}
+
+static bool get_smc_nl_family_id(void)
+{
+	struct sockaddr_nl nl_src;
+	struct msgtemplate msg;
+	struct nlattr *nl;
+	int fd, ret;
+	pid_t pid;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (!ASSERT_GT(fd, 0, "nl_family socket"))
+		return false;
+
+	pid = getpid();
+
+	memset(&nl_src, 0, sizeof(nl_src));
+	nl_src.nl_family = AF_NETLINK;
+	nl_src.nl_pid = pid;
+
+	ret = bind(fd, (struct sockaddr *) &nl_src, sizeof(nl_src));
+	if (!ASSERT_GE(ret, 0, "nl_family bind"))
+		goto fail;
+
+	ret = send_cmd(fd, GENL_ID_CTRL, pid,
+		       NLM_F_REQUEST, CTRL_CMD_GETFAMILY,
+		       CTRL_ATTR_FAMILY_NAME, (void *)SMC_GENL_FAMILY_NAME,
+		       strlen(SMC_GENL_FAMILY_NAME));
+	if (!ASSERT_EQ(ret, 0, "nl_family query"))
+		goto fail;
+
+	ret = recv(fd, &msg, sizeof(msg), 0);
+	if (!ASSERT_FALSE(msg.n.nlmsg_type == NLMSG_ERROR || (ret < 0) ||
+			  !NLMSG_OK((&msg.n), ret), "nl_family response"))
+		goto fail;
+
+	nl = (struct nlattr *) GENLMSG_DATA(&msg);
+	nl = (struct nlattr *) ((char *) nl + NLA_ALIGN(nl->nla_len));
+	if (!ASSERT_EQ(nl->nla_type, CTRL_ATTR_FAMILY_ID, "nl_family nla type"))
+		goto fail;
+
+	smc_nl_family_id = *(uint16_t *) NLA_DATA(nl);
+	close(fd);
+	return true;
+fail:
+	close(fd);
+	return false;
+}
+
+static bool smc_ueid(int op)
+{
+	struct sockaddr_nl nl_src;
+	struct msgtemplate msg;
+	struct nlmsgerr *err;
+	char test_ueid[32];
+	int fd, ret;
+	pid_t pid;
+
+	/* UEID required */
+	memset(test_ueid, '\x20', sizeof(test_ueid));
+	memcpy(test_ueid, SMC_BPFTEST_UEID, strlen(SMC_BPFTEST_UEID));
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (!ASSERT_GT(fd, 0, "ueid socket"))
+		return false;
+
+	pid = getpid();
+	memset(&nl_src, 0, sizeof(nl_src));
+	nl_src.nl_family = AF_NETLINK;
+	nl_src.nl_pid = pid;
+
+	ret = bind(fd, (struct sockaddr *) &nl_src, sizeof(nl_src));
+	if (!ASSERT_GE(ret, 0, "ueid bind"))
+		goto fail;
+
+	ret = send_cmd(fd, smc_nl_family_id, pid,
+		       NLM_F_REQUEST | NLM_F_ACK, op, SMC_NLA_EID_TABLE_ENTRY,
+	(void *)test_ueid, sizeof(test_ueid));
+	if (!ASSERT_EQ(ret, 0, "ueid cmd"))
+		goto fail;
+
+	ret = recv(fd, &msg, sizeof(msg), 0);
+	if (!ASSERT_FALSE((ret < 0) || !NLMSG_OK((&msg.n), ret), "ueid response"))
+		goto fail;
+
+	if (msg.n.nlmsg_type == NLMSG_ERROR) {
+		err = NLMSG_DATA(&msg);
+		switch (op) {
+		case SMC_NETLINK_REMOVE_UEID:
+			if (!ASSERT_FALSE((err->error && err->error != -ENOENT), "ueid remove"))
+				goto fail;
+			break;
+		case SMC_NETLINK_ADD_UEID:
+			if (!ASSERT_EQ(err->error, 0, "ueid add"))
+				goto fail;
+			break;
+		default:
+			break;
+		}
+	}
+	close(fd);
+	return true;
+fail:
+	close(fd);
+	return false;
+}
+
+static bool setup_netns(void)
+{
+	if (!ASSERT_OK(make_netns(TEST_NS), "create net namespace"))
+		return false;
+
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open net namespace"))
+		goto fail_open_netns;
+
+	if (!ASSERT_OK(system("ip addr add 127.0.1.0/8 dev lo"), "add server node"))
+		goto fail_ip;
+
+	if (!ASSERT_OK(system("ip addr add 127.0.2.0/8 dev lo"), "server via risk path"))
+		goto fail_ip;
+
+	return true;
+fail_open_netns:
+	remove_netns(TEST_NS);
+fail_ip:
+	close_netns(nstoken);
+	return false;
+}
+
+static void cleanup_netns(void)
+{
+	close_netns(nstoken);
+	remove_netns(TEST_NS);
+}
+
+static bool setup_ueid(void)
+{
+	/* get smc nl id */
+	if (!get_smc_nl_family_id())
+		return false;
+	/* clear old ueid for bpftest */
+	smc_ueid(SMC_NETLINK_REMOVE_UEID);
+	/* smc-loopback required ueid */
+	return smc_ueid(SMC_NETLINK_ADD_UEID);
+}
+
+static void cleanup_ueid(void)
+{
+	smc_ueid(SMC_NETLINK_REMOVE_UEID);
+}
+
+static bool setup_smc(void)
+{
+	if (!setup_ueid())
+		return false;
+
+	if (!setup_netns())
+		goto fail_netns;
+
+	return true;
+fail_netns:
+	cleanup_ueid();
+	return false;
+}
+
+static int set_client_addr_cb(int fd, void *opts)
+{
+	const char *src = (const char *)opts;
+	struct sockaddr_in localaddr;
+
+	localaddr.sin_family = AF_INET;
+	localaddr.sin_port = htons(0);
+	localaddr.sin_addr.s_addr = inet_addr(src);
+	return !ASSERT_EQ(bind(fd, &localaddr, sizeof(localaddr)), 0, "client bind");
+}
+
+static void run_link(const char *src, const char *dst, int port)
+{
+	struct network_helper_opts opts = {0};
+	int server, client;
+
+	server = start_server_str(AF_INET, SOCK_STREAM, dst, port, NULL);
+	if (!ASSERT_OK_FD(server, "start service_1"))
+		return;
+
+	opts.proto = IPPROTO_TCP;
+	opts.post_socket_cb = set_client_addr_cb;
+	opts.cb_opts = (void *)src;
+
+	client = connect_to_fd_opts(server, &opts);
+	if (!ASSERT_OK_FD(client, "start connect"))
+		goto fail_client;
+
+	close(client);
+fail_client:
+	close(server);
+}
+
+static void block_link(int map_fd, const char *src, const char *dst)
+{
+	struct smc_strat_ip_value val = { .mode = /* block */ 0 };
+	struct smc_strat_ip_key key = {
+		.sip = inet_addr(src),
+		.dip = inet_addr(dst),
+	};
+
+	bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
+}
+
+/*
+ * This test describes a real-life service topology as follows:
+ *
+ *                             +-------------> service_1
+ *            link1            |                     |
+ *   +--------------------> server                   |  link 2
+ *   |                         |                     V
+ *   |                         +-------------> service_2
+ *   |        link 3
+ *  client -------------------> server_via_unsafe_path -> service_3
+ *
+ * Among them,
+ * 1. link-1 is very suitable for using SMC.
+ * 2. link-2 is not suitable for using SMC, because the mode of this link is kind of
+ *     short-link services.
+ * 3. link-3 is also not suitable for using SMC, because the RDMA link is unavailable and
+ *     needs to go through a long timeout before it can fallback to TCP.
+ *
+ * To achieve this goal, we use a customized SMC ip strategy via smc_ops.
+ */
+static void test_topo(void)
+{
+	struct bpf_smc *skel;
+	int rc, map_fd;
+
+	skel = bpf_smc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
+		return;
+
+	rc = bpf_smc__attach(skel);
+	if (!ASSERT_EQ(rc, 0, "bpf_smc__attach"))
+		goto fail;
+
+	map_fd = bpf_map__fd(skel->maps.smc_strats_ip);
+	if (!ASSERT_GT(map_fd, 0, "bpf_map__fd"))
+		goto fail;
+
+	/* Mock the process of transparent replacement, since we will modify protocol
+	 * to ipproto_smc accropding to it via fmod_ret/update_socket_protocol.
+	 */
+	system("sysctl -w net.smc.ops=linkcheck");
+
+	/* Configure ip strat */
+	block_link(map_fd, CLIENT_IP, SERVER_IP_VIA_RISK_PATH);
+	block_link(map_fd, SERVER_IP, SERVER_IP);
+	close(map_fd);
+
+	/* should go with smc */
+	run_link(CLIENT_IP, SERVER_IP, SERVICE_1);
+	/* should go with smc fallback */
+	run_link(SERVER_IP, SERVER_IP, SERVICE_2);
+
+	ASSERT_EQ(skel->bss->smc_cnt, 2, "smc count");
+	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
+
+	/* should go with smc */
+	run_link(CLIENT_IP, SERVER_IP, SERVICE_2);
+
+	ASSERT_EQ(skel->bss->smc_cnt, 3, "smc count");
+	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
+
+	/* should go with smc fallback */
+	run_link(CLIENT_IP, SERVER_IP_VIA_RISK_PATH, SERVICE_3);
+
+	ASSERT_EQ(skel->bss->smc_cnt, 4, "smc count");
+	ASSERT_EQ(skel->bss->fallback_cnt, 2, "fallback count");
+
+fail:
+	bpf_smc__destroy(skel);
+}
+
+void test_bpf_smc(void)
+{
+	if (!setup_smc()) {
+		printf("setup for smc test failed, test SKIP:\n");
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("topo"))
+		test_topo();
+
+	cleanup_ueid();
+	cleanup_netns();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c b/tools/testing/selftests/bpf/progs/bpf_smc.c
new file mode 100644
index 000000000000..a8c62a9882c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	BPF_SMC_LISTEN	= 10,
+};
+
+struct smc_sock___local {
+	struct sock sk;
+	struct smc_sock *listen_smc;
+	bool use_fallback;
+} __attribute__((preserve_access_index));
+
+int smc_cnt = 0;
+int fallback_cnt = 0;
+
+SEC("fentry/smc_release")
+int BPF_PROG(bpf_smc_release, struct socket *sock)
+{
+	/* only count from one side (client) */
+	if (sock->sk->__sk_common.skc_state == BPF_SMC_LISTEN)
+		return 0;
+	smc_cnt++;
+	return 0;
+}
+
+SEC("fentry/smc_switch_to_fallback")
+int BPF_PROG(bpf_smc_switch_to_fallback, struct smc_sock___local *smc)
+{
+	/* only count from one side (client) */
+	if (smc && !BPF_CORE_READ(smc, listen_smc))
+		fallback_cnt++;
+	return 0;
+}
+
+/* go with default value if no strat was found */
+bool default_ip_strat_value = true;
+
+struct smc_strat_ip_key {
+	__u32	sip;
+	__u32	dip;
+};
+
+struct smc_strat_ip_value {
+	__u8	mode;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct smc_strat_ip_key));
+	__uint(value_size, sizeof(struct smc_strat_ip_value));
+	__uint(max_entries, 128);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} smc_strats_ip SEC(".maps");
+
+static bool smc_check_ip(__u32 src, __u32 dst)
+{
+	struct smc_strat_ip_value *value;
+	struct smc_strat_ip_key key = {
+		.sip = src,
+		.dip = dst,
+	};
+
+	value = bpf_map_lookup_elem(&smc_strats_ip, &key);
+	return value ? value->mode : default_ip_strat_value;
+}
+
+SEC("fmod_ret/update_socket_protocol")
+int BPF_PROG(smc_run, int family, int type, int protocol)
+{
+	struct task_struct *task;
+
+	if (family != AF_INET && family != AF_INET6)
+		return protocol;
+
+	if ((type & 0xf) != SOCK_STREAM)
+		return protocol;
+
+	if (protocol != 0 && protocol != IPPROTO_TCP)
+		return protocol;
+
+	task = bpf_get_current_task_btf();
+	/* Prevent from affecting other tests */
+	if (!task || !task->nsproxy->net_ns->smc.ops)
+		return protocol;
+
+	return IPPROTO_SMC;
+}
+
+SEC("struct_ops/bpf_smc_set_tcp_option_cond")
+int BPF_PROG(bpf_smc_set_tcp_option_cond, const struct tcp_sock *tp, struct inet_request_sock *ireq)
+{
+	return smc_check_ip(ireq->req.__req_common.skc_daddr,
+			    ireq->req.__req_common.skc_rcv_saddr);
+}
+
+SEC("struct_ops/bpf_smc_set_tcp_option")
+int BPF_PROG(bpf_smc_set_tcp_option, struct tcp_sock *tp)
+{
+	return smc_check_ip(tp->inet_conn.icsk_inet.sk.__sk_common.skc_rcv_saddr,
+			    tp->inet_conn.icsk_inet.sk.__sk_common.skc_daddr);
+}
+
+SEC(".struct_ops.link")
+struct smc_ops  linkcheck = {
+	.name			= "linkcheck",
+	.set_option		= (void *) bpf_smc_set_tcp_option,
+	.set_option_cond	= (void *) bpf_smc_set_tcp_option_cond,
+};
-- 
2.45.0


