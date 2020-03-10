Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8951804E4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgCJReM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:34:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJReL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:34:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so13517627qka.7
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReiAKbolKC6wqDJ4Eh2p+jV/ZjA8CUv1/dCumntupgg=;
        b=J4Gi7f6L7GtiFhPParI0ZKdg+zxtnSfo0ZVUpL7GurmqaQ5lOdnDfBNpyLw1J0Vr0v
         F1/TMmQu7h2HYM6AxD5ZWXAjtF3qdAXE6kHAg/UFT/MJfFTCyf5OQmfm5NfdNdlQZGQw
         lxKu8qwRo0FaDOzGyXKyTk17462hFCBevw0bI2ZkxFrOyxl+eLKXJdXtI4OyBMKPiD0t
         91GCwA/Dkw7JS56IdBVTR4iHC7aJ7LkYM/G748p3+6oeblouAM25NpYXf+ik4TOI006n
         lSl1lT5NUPEos5NXKTrkhWzyMO3menjTRd+kilIZkVjIYlCvRoB9OHaOBK4JOsRES6sb
         ntpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReiAKbolKC6wqDJ4Eh2p+jV/ZjA8CUv1/dCumntupgg=;
        b=gWFeB0a+nNlxBer3hvTzQgcwyLBnHGxn3oPhEtEicFqvwkJQQxbVJhJA/a8QayMOWj
         Opunqj/7enKuggzb2AHutefrvfHrs7IY4BZixOFh4xXbhFgLPWsaKNxV3LUEmnPXDwt5
         8wKqRAKBa8EKXhKR0laR+lF8r8+u6RudzWldVdpp8CP0EXIraHM1lMcqMsZhFjjDFe9I
         5sPmkOc0nebki06IaVxydRzyyK6vbWHXPf73lpzYjtd5oykZINuV6azPteamFwFB4E7T
         0bddb+KivruNEdu0l3EPPgpML084gU/goRZbbG8JW0SNyItbZJoFPwQ1kM0PpnE2Yk2M
         VouQ==
X-Gm-Message-State: ANhLgQ3zddMyAFUMopEUtntkVif7IijsT5rEmSDUXeDxz77/8eMTN3tt
        EN6B5VKJDsuloHpOLxIZGNI5tg==
X-Google-Smtp-Source: ADFU+vvoSEf6kRCEW6fsQp0DBrXJfLVO+vsBL8MTKO/L0CUfIEYQvV9qZnrFcSzEnNNrET9XnzTFXQ==
X-Received: by 2002:a37:7d2:: with SMTP id 201mr21424287qkh.146.1583861650476;
        Tue, 10 Mar 2020 10:34:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 10sm3686785qtt.65.2020.03.10.10.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:34:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBild-0005j3-GL; Tue, 10 Mar 2020 14:34:09 -0300
Date:   Tue, 10 Mar 2020 14:34:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Remove a redundant 'memset'
Message-ID: <20200310173409.GA21962@ziepe.ca>
References: <20200308065442.5415-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308065442.5415-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 08, 2020 at 07:54:42AM +0100, Christophe JAILLET wrote:
> 'wqe' is already zeroed at the top of the 'while' loop, just a few lines
> below, and is not used outside of the loop.
> So there is no need to zero it here as well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, I reworked it a bit:

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 47b0b50b71e70b..95f6d493d1b98d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2470,15 +2470,12 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 				       struct bnxt_re_qp *qp,
 				       const struct ib_send_wr *wr)
 {
-	struct bnxt_qplib_swqe wqe;
 	int rc = 0, payload_sz = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&qp->sq_lock, flags);
-	memset(&wqe, 0, sizeof(wqe));
 	while (wr) {
-		/* House keeping */
-		memset(&wqe, 0, sizeof(wqe));
+		struct bnxt_qplib_swqe wqe = {};
 
 		/* Common */
 		wqe.num_sge = wr->num_sge;
