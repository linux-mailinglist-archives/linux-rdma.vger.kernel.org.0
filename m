Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252F63FEFF1
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbhIBPRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 11:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhIBPR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 11:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630595790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+xP+wLYOPrkRCNRBb2x5tHhjBwlMaOVmyphk+jfNrg=;
        b=a/sadIS+LBBb9N+0/mKDaM3h25RwI0xAL1jVOpBBBxbpnDJucLleovGv1/VzNg+uwu1GLh
        GMU/ku/ZpJy4JKI+VJk01qYE0JbHJeyI5VuKzDu+MrmmLLto6hR+zlHQZUiiPrdMBB3bUo
        woU/No7e+yg784H/Rr950Qm0PU7Xppo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-FdhtbVkBMSuSGL6m_p2PwQ-1; Thu, 02 Sep 2021 11:16:28 -0400
X-MC-Unique: FdhtbVkBMSuSGL6m_p2PwQ-1
Received: by mail-ed1-f69.google.com with SMTP id e6-20020a056402088600b003c73100e376so1113403edy.17
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+xP+wLYOPrkRCNRBb2x5tHhjBwlMaOVmyphk+jfNrg=;
        b=SYB1E+IzOHZclGQ1NAadCP1FbKi/zLqK1ZWq+KrejJm/dxe4z1sakUMmZlz3QMfxlg
         MQMHuO66UR2QAtc5ztH0g6ykct/Grhi8cdeGHeosXc4xGQ1Vg5CkHxgDWtG8Pyne/xZo
         dGK88qn2viIp9qOUbleEfvVIIAMvVnKnTu1Mrv2GWmSxsBDqH470MB1E+yTsPVAMWtpn
         tvbcikbAn9fIZtUOAuXHjqqKxXsymB0/N5SVEfXS3E+xgGd2jsMl7S2+x2D3JsWyooXK
         e1+mpLkSbPzdjzFq2ldwsOCwwn+++3nH5Pq5In/+682HNyVlye5mCzuW6XeUVnuznKWB
         VRXg==
X-Gm-Message-State: AOAM532f9eRuHbgLw/CKm5FQC4ml0TyQ+xFT0zukhXDEMfJI6aW29iU1
        4T9wWcrDmjhXaf41KivLFg38N2MhQSuu3SHeARLr/JRaT/04h1xGERXn4g6i04jGmvlOJri2BCg
        lVjQ4SCx7+rOXXH7KMuKIrw==
X-Received: by 2002:a05:6402:2909:: with SMTP id ee9mr3940283edb.377.1630595787551;
        Thu, 02 Sep 2021 08:16:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvdswIUfKGCpx598o8TrM8YiJqz9vjAp7AEL9/nn4zRuT+kpCK9mYHSHPKCJI7JCs7p2TIFQ==
X-Received: by 2002:a05:6402:2909:: with SMTP id ee9mr3940266edb.377.1630595787408;
        Thu, 02 Sep 2021 08:16:27 -0700 (PDT)
Received: from redhat.com ([2.55.140.175])
        by smtp.gmail.com with ESMTPSA id bx11sm1366868ejb.107.2021.09.02.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:16:26 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:16:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Junji Wei <weijunji@bytedance.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, jasowang@redhat.com,
        yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com,
        cohuck@redhat.com, hare@suse.de, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: Re: [RFC 5/5] hw/virtio-rdma: VirtIO rdma device
Message-ID: <20210902111601-mutt-send-email-mst@kernel.org>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210902130625.25277-6-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902130625.25277-6-weijunji@bytedance.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 09:06:25PM +0800, Junji Wei wrote:
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index b052355ac7..4c2151bffb 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -48,5 +48,6 @@
>  #define VIRTIO_ID_FS           26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_RDMA         30 /* virtio rdma */

You can start by registering this with the virtio TC.

>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.11.0

