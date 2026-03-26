Return-Path: <linux-rdma+bounces-18707-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KLaAtYoxWkU7QQAu9opvQ
	(envelope-from <linux-rdma+bounces-18707-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 13:38:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4C33551B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBF430E6C3D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555733F87E2;
	Thu, 26 Mar 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnn8Szsa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D73F8E00
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528356; cv=none; b=k755A7GuNm+dwfTj7NgoJkDyS1CY+Mu5C+Ef0aA/kyj6ikYysEcHeKJxrltXrYEFxBTJoT1OEgg3YQbHck3VuGJi187LeMvNLre34euZbODEQE2iv8HJkidGMYjEu/k8XBowRR9ZT4iofWzyHyDdV+YIjRg7MKB+79Mj51mNvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528356; c=relaxed/simple;
	bh=ZEGAUcvooReaJ1XmRJnQfzG/aLY4zKJA94CADfSupZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0btZWX36gs4HrlajFLtYXr1ALiErJN5mpgtgRqvQ7kmY8WxXw0HOavJ0YL5eMbLZ3GAdtQZVrIVpfovCRFpZvJ6Eudv2SQuDv3EdZ2bIB4dJZtvZIiUzcJvJ1xUdXEYzSrgfnANyzSAUs21izHPGS+9zZuy+nSRE0cOk/jmqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnn8Szsa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso17724915e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774528353; x=1775133153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
        b=pnn8SzsaxWdT1Xg7bun4HelpBTaPt2xL5Ka6sp5j8DTsXSpU2WAsbA3TELSLbYAFdy
         BmzQBUatwrqo8rObW4ddm8mkrjc6kCFuj8a5R2gtQYVh4CCL64Rn2oy4IY2ymGebHjhi
         zlHCpFB5KCjkTlB3bfEc7elT9nYuQ9i6LPIdmgJJscO+ZNk1k35WIJulubbfe8NggxLP
         3zQy7tNjXAYOqqhnUrp74tJMbjLjNusJcK0aGeLbuIotj4vjeVTVliRpWff/V7q/tbIB
         efq5L5NgfqARFrJu9d1DymS2RHzbowq5/Z1wD8jTqIRK/jbSJTSNidRzOuhm17wZDkuG
         gWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528353; x=1775133153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
        b=BgIHxLJFnZRvUin61iTPruqUWUXcIVAjjkanCL+2N6WVcRyH/rvoyH+4MfQoFDo9+Z
         E6zNn8ViLeIiQL8UJYOkXBU6Y3kvXImntOOiknTiux9xiysKebduemeG+vj3r6/D8ZTr
         L36zouTS7sSZg3WGs8n3dYgvKfdpXNZTThNi3jfK3k3cAKb0BoPB/4rBW5rxmElXeM1X
         nK48XaFp7zfkZQ8W+HnRNwFWcFtSNnwRxMYsRH0WYF1CVHh9C6RKR31Ot0Td86viEnPk
         hsW2XvmBBOppxxwq4HbVD+4tvz/0AkKEyxhyBqr3lgd8rBQ1gkrR0CMyM5Qka0otgrzU
         JeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOs+QbLVVL2/hnqrJv1XW4u5dezAnZl0XUnwewPBUuohnIwiXjCEsrMAy9ibv6UqocCJ2eBwShiVdU@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIakjwC0EeYDF3dydtPO3MBDWKCXVIXo+TctXuhMbrr1zcA9b
	7h0anhBzV3ArjZ2O1t619BxiBoM5kchkF6JZfKriWhWKkPIYev3GFpIomJFRa5z+65vKXZhtC+Q
	apFiCfrxi9HKuvg==
X-Received: from wmoo19.prod.google.com ([2002:a05:600d:113:b0:487:238e:327b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id 5b1f17b1804b1-48716071b2amr111318865e9.24.1774528352832;
 Thu, 26 Mar 2026 05:32:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:59 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-3-d916021cecdf@google.com>
Subject: [PATCH v2 3/4] mm/kfence: Use special gfp_t format specifier
From: Brendan Jackman <jackmanb@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Allison Henderson <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18707-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73D4C33551B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

%pGg produces nice readable output and decouples the format string from
the size of gfp_t.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/kfence/kfence_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 5725a367246d9..10424cd25e5a6 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -263,7 +263,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 		break;
 	}
 
-	kunit_info(test, "%s: size=%zu, gfp=%x, policy=%s, cache=%i\n", __func__, size, gfp,
+	kunit_info(test, "%s: size=%zu, gfp=%pGg, policy=%s, cache=%i\n", __func__, size, &gfp,
 		   policy_name, !!test_cache);
 
 	/*

-- 
2.51.2


