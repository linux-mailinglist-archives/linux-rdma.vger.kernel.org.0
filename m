Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0328F287F5D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJIACe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgJIACe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 20:02:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE090C0613D2;
        Thu,  8 Oct 2020 17:02:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l16so7602642eds.3;
        Thu, 08 Oct 2020 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GhVFR2anfqi/iNioQ+Ge255uzt1ydh5lKOCkiLHnrXI=;
        b=AcYiWVzLRtt58/ab6QInE9XuUWjEoSPIvGHJSiXCf7LRe8jSH1KDQdRQMAazwQZlWC
         ytC2uXoQuFoYh0tgQ/8S2upSxpM4VeUegnt4ALW9HpI4az0EhF7X0TcyN8Z17UvEDr2M
         SvYAwI0t4GpX71QO+1dPcNZTbMcxzL/0+Mi5nnupQfflL2GXHVAUzh/Vwbxpk7sPWBK5
         ePGiaMUFKJennlreGsSGe8SecEBMcZX9BsucCZsOQfXreUNlJieBoB44Y6T++Er/8GaF
         e1psULzmQQU/pgBdEdVWJOWAUJFTh7/6OfJ5ea21Vxm5K723wu2tydn8EfnUTxbhTRMA
         GWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GhVFR2anfqi/iNioQ+Ge255uzt1ydh5lKOCkiLHnrXI=;
        b=MGjjP7czVGIVEGf/q80j27bgWMMBfI9BHVmfDq139ouCKgBCEdUkAIFCswegirikHP
         qkPQbU8kUBGJ1e4rF1tTN7BIi9AlzMeOjy4E/Danjm3f5g6t3gGddxtVIiEi3NM9R85z
         Y7ZJZ0apB3fM5RXUhnqzgzhxX1RAa1VChMnC+uhWFT7B+xLCPQBLZfLNo3x7MOb+xk29
         xg61VQDEbt0aywAyvDXS1qzD1t0roPJ30q2CrnxBychM9BO/EDgVXdjQIXLr/pircPD0
         ixN1wFHM4Fc01qvS/pnA+5tGZxlXdENCNpUUEF3Z3fJ/+aiCTc1wlLUv7kWCzOipjZLq
         5PcQ==
X-Gm-Message-State: AOAM530niBT45bYrOKvXxxR17OVmZu9lLQo8NG44JRohU8i/so1ibRQX
        19aOoMGn2E/7EuEBNMhhP9pJPQ4XYHb8TSb4SP6K/a3ir6VOoQ==
X-Google-Smtp-Source: ABdhPJwCkSBriuq2l2DcuGWPRBdnIxHzxNuW8JwRwD35DLpjlN7W00MNuW49xhqz5OopfNLwEIHB4PYOnJC6z+KsRtE=
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr11989861edb.359.1602201752216;
 Thu, 08 Oct 2020 17:02:32 -0700 (PDT)
MIME-Version: 1.0
From:   marc spencer <i.am.mark.spencer@gmail.com>
Date:   Fri, 9 Oct 2020 05:31:38 +0530
Message-ID: <CAEonGa5As=W01GZw7V9W2Y2J+-XV=S+KfsF9XAPm9m_D1wy0wA@mail.gmail.com>
Subject: syndrome list mlx5
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Where can I get access to mlx5 syndrome list for e.g when a HCA
command is issued, we get a return status
(OK/INTERNAL_ERR/BAD_OP/BAD_RES_STATE etc) and also syndrome.

To decode the syndrome, I believe there is a list from Mellanox. Can
anyone point me to such a list?

Thanks
Best Regards
Marc
