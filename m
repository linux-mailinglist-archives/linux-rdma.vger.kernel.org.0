Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C170633D3A6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Mar 2021 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCPMRN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Mar 2021 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhCPMQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Mar 2021 08:16:41 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4EC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 05:16:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r24so8445966otq.13
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
        b=ZIHVHbWsPnBzTU8KH3wouqolADqEvgUolxwSP7cqgQZdxFQerZphHVHL9lIla971fA
         b56bhfDwU3owqV/QqopG8CdgIRelvjA6/Q3rMw5QWEDhFqKh3xYZ/KNh8mD3HIfYPJ3s
         zszmdrjg3tFgjJ971nnUJjauNeA9Oha8XL36dBcg80pAfjslIn40sJdiUGDMB8xk+ZpB
         M3SeSB6gtuqx8qdSCodykyqVAbTyu5aR22GMZ6hGvFRRJFTeTDKFxXSylvsHzqTMBAal
         knze+0gg8hJB8D55KAMLfuAh9XpvrwswUf/ca1VmfptU0YE369C6uiUu7FomOFfnjMSS
         ao7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
        b=GsH6Ckiw4cCSqw8u+6lQ7Hwel3UU5UmB3ncu4vh2J+iBIRQ93Bc24ULSVccoNCnkPL
         krLnLDpsNpOQGwUoa9Y3HTwrjBMns+vzQRENNFPtaar5dM7wfzNFuKQHRH4AfpIjnAJ6
         zMYRpMfL2LtdlUcEyPXYPGUJI3/k7zAJkwvVx5056WIAJ8fdS6k0mDsEY9zs+ugu1pcA
         Kh+9e0a65i8IffyYcQL6qqKMksWVZagB9/5dFI8ure3c5GcteoOsA0DiHXHN/AjfO1X9
         UIXQBfsTW9jFkiJ9aIQH+lsc11twyyOHjTNVgQmr/5WSSQ9PDoioIQdBpt+BHPq59R7D
         Nceg==
X-Gm-Message-State: AOAM531y6WF4FIZv38AgA/nScPoTO7WBheMAp7Dgs3x0NJkX+AOabHMD
        x5RzI0MZAgJGOTM+AUgWql2A/sFpDTrMMBp4wSOfNYe+FXPFTHfa
X-Google-Smtp-Source: ABdhPJy9oQYJWaVmHx20i9e9pL3xd3FVzNOsB007alSNmEBbX8iLvW/As7a3qb0h/uxugPx1IxSAsBIvoDlQ+iIAx2g=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr3419600ota.164.1615896997960;
 Tue, 16 Mar 2021 05:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMCTd2kkax9P-OFNHYYz8nKuaKOOkz-zoJ7h2nZ6maUGmjXC-g@mail.gmail.com>
In-Reply-To: <CAMCTd2kkax9P-OFNHYYz8nKuaKOOkz-zoJ7h2nZ6maUGmjXC-g@mail.gmail.com>
From:   "westjoshuaalan@gmail.com" <westjoshuaalan@gmail.com>
Date:   Tue, 16 Mar 2021 06:16:02 -0600
Message-ID: <CAMCTd2mRBnUPR1WOSj2xTMKz5WK=ZUsFp5X0JWaDeeEJkFbs0Q@mail.gmail.com>
Subject: Re:
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

subscribe linux-rdma
