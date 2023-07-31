Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636CD7695C1
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGaMNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGaMNa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 08:13:30 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74D0D10DF;
        Mon, 31 Jul 2023 05:13:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [125.120.146.22])
        by mail-app2 (Coremail) with SMTP id by_KCgDHP8NMpcdkbRbaCg--.54964S4;
        Mon, 31 Jul 2023 20:13:01 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, fw@strlen.de, yang.lee@linux.alibaba.com,
        jgg@ziepe.ca, markzhang@nvidia.com, phaddad@nvidia.com,
        yuancan@huawei.com, linma@zju.edu.cn, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, aharonl@nvidia.com, leon@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH net v1 1/2] netlink: let len field used to parse type-not-care nested attrs
Date:   Mon, 31 Jul 2023 20:12:47 +0800
Message-Id: <20230731121247.3972783-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDHP8NMpcdkbRbaCg--.54964S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr18JF45tF15Kw17GryUWrg_yoWrGFW5pF
        Wvkryjyr9xGryxCr92kr1Iga4aqr18JrZ8GrZ8Xws7ZFs0g3srG34rWFnIva4I9F48Ja17
        tF1YgrW3uF1UZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvt
        AUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Recently I found several manual parsing cases for nested attributes
whose fix is rather trivial. The pattern for those like below

const struct nla_policy y[...] = {
  ...
  X	= { .type = NLA_NESTED },
  ...
}

nla_for_each_nested/attr(nla, tb[X], ...) {
   // nla_type never used
   ...
   x = nla_data(nla) // directly access nla without length checking
   ....
}

One example can be found in discussion at:
https://lore.kernel.org/all/20230723074504.3706691-1-linma@zju.edu.cn/

In short, the very direct idea to fix such lengh-check-forgotten bug is
add nla_len() checks like

  if (nla_len(nla) < SOME_LEN)
    return -EINVAL;

However, this is tedious and just like Leon said: add another layer of
cabal knowledge. The better solution should leverage the nla_policy and
discard nlattr whose length is invalid when doing parsing. That is, we
should defined a nested_policy for the X above like

  X      = { NLA_POLICY_NESTED(Z) },

But unfortunately, as said above, the nla_type is never used in such
manual parsing cases, which means is difficult to defined a nested
policy Z without breaking user space (they may put weird value in type
of these nlattrs, we have no idea).

To this end, this commit uses the len field in nla_policy crafty and
allow the existing validate_nla checks such type-not-care nested attrs.
In current implementation, for attribute with type NLA_NESTED, the len
field used as the length of the nested_policy:

	{ .type = NLA_NESTED, .nested_policy = policy, .len = maxattr }

	_NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)

If one nlattr does not provide policy, like the example X, this len
field is not used. This means we can leverage this field for our end.
This commit introduces one new macro named NLA_POLICY_NESTED_NO_TYPE
and let validate_nla() to use the len field as a hint to check the
nested attributes. Therefore, such manual parsing code can also define
a nla_policy and take advantage of the validation within the existing
parsers like nla_parse_deprecated..

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 include/net/netlink.h |  6 ++++++
 lib/nlattr.c          | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index b12cd957abb4..d825a5672161 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -229,6 +229,9 @@ enum nla_policy_validation {
  *                         nested header (or empty); len field is used if
  *                         nested_policy is also used, for the max attr
  *                         number in the nested policy.
+ *                         For NLA_NESTED whose nested nlattr is not necessary,
+ *                         the len field will indicate the exptected length of
+ *                         them for checking.
  *    NLA_U8, NLA_U16,
  *    NLA_U32, NLA_U64,
  *    NLA_S8, NLA_S16,
@@ -372,6 +375,9 @@ struct nla_policy {
 	_NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)
 #define NLA_POLICY_NESTED_ARRAY(policy) \
 	_NLA_POLICY_NESTED_ARRAY(ARRAY_SIZE(policy) - 1, policy)
+/* not care about the nested attributes, just do length check */
+#define NLA_POLICY_NESTED_NO_TYPE(length) \
+	_NLA_POLICY_NESTED(length, NULL)
 #define NLA_POLICY_BITFIELD32(valid) \
 	{ .type = NLA_BITFIELD32, .bitfield32_valid = valid }
 
diff --git a/lib/nlattr.c b/lib/nlattr.c
index 489e15bde5c1..29a412b41d28 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -488,6 +488,18 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 				 */
 				return err;
 			}
+		} else if (pt->len) {
+			/* length set without nested_policy, the len field will
+			 * be used to check those nested attributes here,
+			 * we will not do parse here but just validation as the
+			 * consumers will do manual parsing.
+			 */
+			const struct nlattr *nla_nested;
+			int rem;
+
+			nla_for_each_attr(nla_nested, nla_data(nla), nla_len(nla), rem)
+				if (nla_len(nla_nested) < pt->len)
+					return -EINVAL;
 		}
 		break;
 	case NLA_NESTED_ARRAY:
-- 
2.17.1

