Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6F450DA
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFNAo7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36878 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfFNAo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so634702qkl.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJP3s5LCTJOa2Bpv3WsF12kBeuFb/g7s2rVIALekTDo=;
        b=dyouVytY+jmXKdkQ6AEcE55kZQEWs6bscsYHu17tMqMjO0ykbKjOyu4AZmogdzcKOO
         okRY9yuPH0h4p3cAV4QrnZ4n34NPuyuK97/dkGmB3VzQKnqK9s/XAJtvvIAGZkXqI8Jd
         kp8Bb3YU8e6ArRWr/jcI134rAI1zQOreSW9nSzEGghOTmJk/pJslGcpZKvhe05E8ekCA
         wMSMERjmVYizkkeqJXXp4Y3n+nU+hNQwdsuP0lS3FbYfoYhnJGG75bzPsyyRZjGeXB24
         rhFdNEenuxIK01r0M01cZSie0WszSDebNOB+aFhxWAf9m8Ut+WvZhCrUuTgOing0GJS6
         L08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJP3s5LCTJOa2Bpv3WsF12kBeuFb/g7s2rVIALekTDo=;
        b=rIhdlIFiHrmdeWd6PhzuqREypXSNKXhyaRLKlkQbq+Gj+p+We2CTY8KXBHqkLDNj1X
         sXN8ed73HZGYkHy9kHK4kVXq80hAin6NCJRtwBCk8oyGWgcD2uhA8hOhdGiLpqB/Illl
         wxHpTwLwa3mbuqJKdipKf/SXpgWZUI0vhMFCgiY2Mh+MRNM92ZFGu+c0FeSHd5C3PF+c
         yTX6sUHn5PKJ5crhgGuJHRbPl54rAoXk655nXpvAafbJqgml89mlnFepzYnCKK8db0ME
         cxXoeobPR3jzwADP/QtsaLjqANnYE6fVQyOPpbkvroCwqvEcECrf9DHkLy7KH7qFcmWa
         SGcQ==
X-Gm-Message-State: APjAAAVUx/ngsow5JuFekQ0aYWD1+q9VikGYL9F8s8+Qm2fZKqr9fPwI
        uEiEkpNCkpJ6QJF10m1CclZDAQ==
X-Google-Smtp-Source: APXvYqwYuZdBUIyBE3tnoT2pvasr4EEIwX7YCMbTNFDbznpFFTMobqSAyRGm2KIgVEvCZYbf+NYJww==
X-Received: by 2002:a05:620a:144a:: with SMTP id i10mr72376829qkl.130.1560473097962;
        Thu, 13 Jun 2019 17:44:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m21sm498643qtp.92.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005KE-Ue; Thu, 13 Jun 2019 21:44:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 08/12] mm/hmm: Remove racy protection against double-unregistration
Date:   Thu, 13 Jun 2019 21:44:46 -0300
Message-Id: <20190614004450.20252-9-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No other register/unregister kernel API attempts to provide this kind of
protection as it is inherently racy, so just drop it.

Callers should provide their own protection, it appears nouveau already
does, but just in case drop a debugging POISON.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c0f622f86223c2..e3e0a811a3a774 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -283,18 +283,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
  */
 void hmm_mirror_unregister(struct hmm_mirror *mirror)
 {
-	struct hmm *hmm = READ_ONCE(mirror->hmm);
-
-	if (hmm == NULL)
-		return;
+	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
 	list_del_init(&mirror->list);
-	/* To protect us against double unregister ... */
-	mirror->hmm = NULL;
 	up_write(&hmm->mirrors_sem);
-
 	hmm_put(hmm);
+	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
 
-- 
2.21.0

