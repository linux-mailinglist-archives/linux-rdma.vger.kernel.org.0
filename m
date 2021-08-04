Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377253E06C5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhHDRbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhHDRbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 13:31:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6892CC0613D5
        for <linux-rdma@vger.kernel.org>; Wed,  4 Aug 2021 10:31:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j3so3774377plx.4
        for <linux-rdma@vger.kernel.org>; Wed, 04 Aug 2021 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seas-upenn-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=vAcxpRi1fLtdL6VpvNwlfcr7U9THnIk0BEaXKvUppys=;
        b=BK93kMEss9rd27NDYvmzSynyFjbwsHKfUgV2yoHrL8IsWeFDpcBpS9/4FRUcHKoGb+
         tBOt6fvh4msY+40xIqCIYnoDvf+R2rlfANDdqdTO4nqiVb9hVmLM5ddkqtVmyugaNcqj
         PvBr/k2s9bFFOf4nMOnZ7aa/Yty+T7ayC6NpiGrToJ8Grt12T8iEr9GVy8vPJ0EN1bua
         k4C7qwSCxvjmd5nSQ0t35BC2NNqd5pmEKWsh38ffDiMXXxVhU6m1ZrA5Cc5yMMSVGngk
         dIHxhNTJX+eLNxOaWN6lRD/CwFwZaQPlSdZFY5OYUSu+MUp4goeginze3ps32HJTcz+v
         P3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vAcxpRi1fLtdL6VpvNwlfcr7U9THnIk0BEaXKvUppys=;
        b=dBTIyCjnxAvWxZEVnPrTjk5OlDNfQ1Oh8Im6zEZh19GsQOsss+jSKonZRqaGt0YMqU
         F4WXo0lnYgzrQYOSEeWStA3NauqS6A/8bg6cQIS1vFrqg6iF4QNB6iANVt9Rkb+9lBre
         HMqc8j8Bvs8gmd/uFro89bQ5LpbGFHyADCd5m0v67S5+U0N5bdfuqVuCy/6LlkLn0adf
         SKn3+Ep6dtX1fGYT9njNTN/f21qcSFBpr2P7FWH04H6lMZYvpPGzoi5M/pUUDy06bai5
         5MFpFQlowifXsnLYjv9LaMe8XodLIrhkaTc7L02gOBC9vKaTEfshPDk0/Bk31JOSarRQ
         D2Qg==
X-Gm-Message-State: AOAM532q8sE0ZW1gUnuZUvEZQaSAhrQyN/37JJ6KXpqaFITwrpm0NXId
        xLRUKH8tgnmIsaEKkEYqdY3naXsTbQx4sjZ7aXpNArBcUFiceg==
X-Google-Smtp-Source: ABdhPJxtjcKKSat3nNxfbuHxkUwTog0qR0eikz4TxBnrkmX+QQtu3oXCh3CaPdd7ffsXLjwkxzBudLdEygLnZAgkaug=
X-Received: by 2002:a17:90a:98b:: with SMTP id 11mr252613pjo.144.1628098264777;
 Wed, 04 Aug 2021 10:31:04 -0700 (PDT)
MIME-Version: 1.0
From:   Omar Navarro Leija <omarsa@seas.upenn.edu>
Date:   Wed, 4 Aug 2021 13:30:54 -0400
Message-ID: <CAMAtMKd2b6mKauR5HmCwEqFpHZ=me+Qn+hU_7CewETUBDnMF7Q@mail.gmail.com>
Subject: Incorrect Return Type for rdma_destroy_qp
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

The man page has rdma_destroy_qp as:

#include <rdma/rdma_cma.h>
void rdma_destroy_qp (struct rdma_cm_id *id);


Note the void return type. Yet the return value section states:

Return Value
Returns 0 on success, or -1 on error. If an error occurs, errno will
be set to indicate the failure reason. Indeed the implementation is
written as:

void rdma_destroy_qp(struct rdma_cm_id *id)
{
ibv_destroy_qp(id->qp);
id->qp = NULL;
ucma_destroy_cqs(id);
}

I believe  rdma_destroy_qp should return an int which propagates the
return value of calling ibv_destroy_qp. As a workaround, I just call
ibv_destroy_qp directly.

Omar
